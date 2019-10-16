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
export NAMESAPCE=postgres

gcloud config set core/project $PROJECT

gcloud container clusters create $CLUSTER_NAME \
    --zone=$CLUSTER_ZONE \
    --cluster-version=$CLUSTER_VERSION \
    --machine-type=$MACHINE_TYPE \
    --enable-autoscaling --min-nodes=$MIN_NODES --max-nodes=$MAX_NODES \
    --enable-autorepair \
    --num-nodes=$NUM_NODES

gcloud container clusters get-credentials $CLUSTER_NAME --zone $CLUSTER_ZONE

gcloud --project=$PROJECT beta sql instances create $INSTANCE_NAME \
	  --cpu=$CPUS \
	  --database-version=$DB_VERSION \
	  --memory=$MEMORY_SIZE \
	  --zone=$CLUSTER_ZONE \
    --network=$NETWORK \
    --root-password=$ROOT_PASSWORD \
    --no-assign-ip

DB_HOST=$(gcloud sql instances list | grep $INSTANCE_NAME | awk '{print $6}')

ENCODE=$(echo $DB_HOST | base64)

cp pgenv.yaml secrets.old
sed 's/_ENCODE_/'$ENCODE'/g' pgenv.yaml > env.yaml
mv env.yaml pgenv.yaml

kubectl create namespace $NAMESAPCE
kubectl apply -f pgenv.yaml -n $NAMESAPCE
kubectl apply -f pgset.yaml -n $NAMESAPCE

mv secrets.old pgenv.yaml

echo 'cluster created successfully by Abbas'
