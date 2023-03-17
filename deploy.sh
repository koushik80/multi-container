docker build -t koushik80/multi-client -f ./client/Dockerfile ./client
docker build -t koushik80/multi-server -f ./server/Dockerfile ./server
docker build -t koushik80/multi-worker -f ./worker/Dockerfile ./worker
docker push koushik80/multi-client
docker push koushik80/multi-server
docker push koushik80/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=koushik80/multi-server