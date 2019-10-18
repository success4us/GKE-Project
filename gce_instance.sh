export INSTANCE_NAME=new-instance
export MACHINE_TYPE=f1-micro
export IMAGE_FAMILY=ubuntu-1604-lts
export IMAGE_PROJECT=ubuntu-os-cloud
export ZONE=us-central1-a

gcloud compute instances create $INSTANCE_NAME \
	--machine-type=$MACHINE_TYPE \
	--image-family=$IMAGE_FAMILY --image-project=$IMAGE_PROJECT \
	--zone=$ZONE