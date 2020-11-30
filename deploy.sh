docker build -t sergiohpreis/multi-client:latest -t sergiohpreis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sergiohpreis/multi-server:latest -t sergiohpreis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sergiohpreis/multi-worker:latest -t sergiohpreis/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sergiohpreis/multi-client:latest
docker push sergiohpreis/multi-client:$SHA
docker push sergiohpreis/multi-server:latest
docker push sergiohpreis/multi-server:$SHA
docker push sergiohpreis/multi-worker:latest
docker push sergiohpreis/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sergiohpreis/multi-server:$SHA
kubectl set image deployments/client-deployment client=sergiohpreis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sergiohpreis/multi-worker:$SHA