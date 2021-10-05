docker build -t cheonu/multi-client:latest -t cheonu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cheonu/multi-server:latest -t cheonu/multi-server:$SHA -f ./server/Dockerfile ./client
docker build -t cheonu/multi-worker:latest -t cheonu/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push cheonu/multi-client:latest
docker push cheonu/multi-server:latest
docker push cheonu/multi-worker:latest
docker push cheonu/multi-client:$SHA
docker push cheonu/multi-server:$SHA
docker push cheonu/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cheonu/multi-server:$SHA
kubectl set image deployments/client-deployment client=cheonu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cheonu/multi-worker:$SHA