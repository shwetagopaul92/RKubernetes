#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
vcffile = args[1]
radius = as.numeric(args[2])
genes = args[3]
doVariants  <- function(vcffile,radius,genes){
   #library(BiocManager)
   #BiocManager::install("variants",version="3.9")
   library(variants)
   r = as.numeric(radius)
   file <- system.file('vcf', vcffile, package = 'cgdv17')
   genesym <- genes
   geneid <- select(org.Hs.eg.db, keys=genesym, keytype='SYMBOL',columns='ENTREZID')
   txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
   seqlevelsStyle(txdb) = 'NCBI'
   txdb <- keepSeqlevels(txdb, '17')
   txbygene = transcriptsBy(txdb, 'gene')
   gnrng <- unlist(range(txbygene[geneid[['ENTREZID']]]), use.names=FALSE)
   names(gnrng) <- geneid[['SYMBOL']]
   param <- ScanVcfParam(which = gnrng+r, info = 'DP', geno = c('GT', 'cPd'))
   vcf <- readVcf(file, 'hg19', param)
   ans = locateVariants(vcf, txdb, AllVariants())
   table(mcols(ans)[['LOCATION']])
   names(ans) = make.names(names(ans),unique=TRUE)
   #write.csv(as.data.frame(ans), 'output.csv')
   print(as.data.frame(ans))

}
#vcffile = args[1]
#radius = args[2]
#genes = args[3]
doVariants(vcffile,radius,genes)
