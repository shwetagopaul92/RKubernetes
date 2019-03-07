# RKubernetes

# To submit a variant annotation job to Kubernetes 

- Create a kubernetes cluster "variants"
# create 4 node cluster "variants" on google kubernetes engine
gcloud container clusters create variants --machine-type n1-standard-1 --num-nodes 4

# get credentials to point kubectl to our cluster
gcloud container clusters get-credentials kubepar

1. In R, source runJob.R
2. Point to the directory structure shown
3. Create jobs for the .yaml files 
> kubectl create -f job1.yaml 
or 
> kubectl create -f . (to create jobs for all the .yaml file present in the directory)


General procedure to create, run, monitor jobs on Kubernetes

# Docker:

- Create a Docker image with the required Rscript file. 

# Kubernetes YAML:

- Create a job.yaml file that contains instructions for the controller.

# Deploy job to kubernetes:

- Install Google Cloud SDK (https://cloud.google.com/sdk/)
- Install kubectl (https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Follow these steps (change cluster name and job file as required) 

# create 4 node cluster "kubepar" on google kubernetes engine
gcloud container clusters create kubepar --machine-type n1-standard-1 --num-nodes 4
# get credentials to point kubectl to our cluster
gcloud container clusters get-credentials kubepar
# create job
kubectl create -f job.yaml

# Monitor pods, jobs, nods with kubectl 

## Cheatsheet for some kubectl commands 

kubectl describe jobs
kubectl describe pods
kubectl get nodes
kubectl delete job "jobname"
kubectl logs "podname" (can be got from "Events" when we run kubectl describe jobs) 

Kubernetes clusters can be deleted on the Kubernetes Engine Google Cloud console. 




