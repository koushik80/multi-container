docker build -t koushik80/multi-client:latest -t koushik80/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t koushik80/multi-server:latest -t koushik80/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t koushik80/multi-worker:latest -t koushik80/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push koushik80/multi-client:latest
docker push koushik80/multi-server:latest
docker push koushik80/multi-worker:latest

docker push koushik80/multi-client:$SHA
docker push koushik80/multi-server:$SHA
docker push koushik80/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=koushik80/multi-server:$SHA
kubectl set image deployments/client-deployment client=koushik80/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=koushik80/multi-worker:$SHA