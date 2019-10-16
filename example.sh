DB_HOST=$(gcloud sql instances list | grep $INSTANCE_NAME | awk '{print $6}')

ENCODE=$(echo $DB_HOST | base64)

cp pgenv.yaml secrets.old
sed 's/_ENCODE_/'$ENCODE'/g' pgenv.yaml > env.yaml
mv env.yaml pgenv.yaml

kubectl create namespace deploy
kubectl apply -f pgenv.yaml -n deploy
kubectl apply -f pgset.yaml -n deploy


mv secrets.old pgenv.yaml

echo 'cluster created successfully by Abbas'
