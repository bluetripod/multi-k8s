docker build -t pkansal/multi-client:latest -t pkansal/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t pkansal/multi-server:latest -t pkansal/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t pkansal/multi-worker:latest -t pkansal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pkansal/multi-client:latest
docker push pkansal/multi-server:latest
docker push pkansal/multi-worker:latest

docker push pkansal/multi-client:$SHA
docker push pkansal/multi-server:$SHA
docker push pkansal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pkansal/multi-server:$SHA
kubectl set image deployments/client-deployment client=pkansal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pkansal/multi-worker:$SHA