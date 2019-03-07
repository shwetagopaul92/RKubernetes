jobyaml = 'apiVersion: batch/v1
kind: Job
metadata:
  name: annotate-variant-%i
spec:
  template:
    metadata:
      name: var-example
      labels:
        jobgroup: var-example
    spec:
      containers:
      - name: variantannotation
        image: reshg/var:v2
        command: ["Rscript", "variants.R"]
        args: ["%s","%i","%s"]
      restartPolicy: Never'

genes = "TRPV1"
radius = 20000
vcfs = c("NA20847_17.vcf.gz","NA06985_17.vcf.gz")

createJobs <- function(vcfs, radius, genes){
  mydir = tempdir()
  print(mydir)
  for(i in 1:length(vcfs)){
    fname = paste0(mydir,"/variantjob",i,".yaml")
    temp = sprintf(jobyaml,i,vcfs[i],radius,paste(genes,collapse=","))
    writeLines(temp,fname)
  }
}

createJobs(vcfs=vcfs,radius=radius,genes=genes)
