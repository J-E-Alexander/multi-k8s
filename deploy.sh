docker build -t shaddass/multi-client:latest -t shaddass/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shaddass/multi-server:latest -t shaddass/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shaddass/multi-worker:latest -t shaddass/multI-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shaddass/multi-client:latest
docker push shaddass/multi-server:latest
docker push shaddass/multi-worker:latest

docker push shaddass/multi-client:$SHA
docker push shaddass/multi-server:$SHA
docker push shaddass/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shaddass/multi-server:$SHA
kubectl set image deployments/client-deployment client=shaddass/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shaddass/multi-worker:$SHA