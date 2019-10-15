export CLUSTER_NAME=new-cluster
export CLUSTER_ZONE=us-central1-a
export PROJECT=s4-project-202316
export CLUSTER_VERSION=latest
export MACHINE_TYPE=g1-small
export MIN_NODES=1
export MAX_NODES=5
export INSTANCE_NAME=new-instance1
export DB_VERSION=POSTGRES_9_6
export CPUS=2
export MEMORY_SIZE=10
export NUM_NODES=1
export ROOT_PASSWORD=admin
export NETWORK=default

gcloud config set core/project $PROJECT

# gcloud container clusters create $CLUSTER_NAME \
#     --zone=$CLUSTER_ZONE \
#     --cluster-version=$CLUSTER_VERSION \
#     --machine-type=$MACHINE_TYPE \
#     --enable-autoscaling --min-nodes=$MIN_NODES --max-nodes=$MAX_NODES \
#     --enable-autorepair \
#     --num-nodes=$NUM_NODES

# gcloud container clusters get-credentials $CLUSTER_NAME --zone $CLUSTER_ZONE

gcloud --project=$PROJECT beta sql instances create $INSTANCE_NAME \
	  --cpu=$CPUS \
	  --database-version=$DB_VERSION \
	  --memory=$MEMORY_SIZE \
	  --zone=$CLUSTER_ZONE \
    --network=$NETWORK \
    --root-password=$ROOT_PASSWORD \
    --no-assign-ip

echo 'cluster created successfully by Abbas'
