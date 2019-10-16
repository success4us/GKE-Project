#!/bin/bash
read -p "Which Platform AWS or GCP: " cloud_platform


if [ "$cloud_platform" = "gcp" ] ; then
    read -p "GCE or GKE: " google_engine
elif [[ "$cloud_platform" = "aws" ]]; then
	 read -p "EC2 or AKS: " amazon_engine
else 
	echo "invalid input"
	exit
fi



if [ "$google_engine" = "gce" ] ; then
	echo "creating google compute engine"
elif [[ "$google_engine" = "gke" ]]; then
	echo "creating google kubernetes engine"
	# ./gke_cluster.sh
else 
	echo "invalid google engine"
	exit
fi



if [ "$amazon_engine" = "ec2" ]; then
	echo "creating ec2 instance"
elif [[ "$amazon_engine" = "aks" ]]; then
	echo "creating amazon kubernetes engine"
else 
	echo "invalid amazon engine"
	exit
fi



# if [ "$cloud_platform" = "aws" ] ; then
#     read -p "EC2 or AKS: " engine
# fi

# if [ "$cloud_platform" = "gcp" ] || [ "$cloud_platform" = "aws" ]; then
#     read -p "Which Platform AWS or GCP: " cloud_platform
# fi