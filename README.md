
docker build -f <DOCKERFILE_NAME> -t <IMAGE_NAME>:latest .

docker run --gpus '"device=0"' -it --rm  <IMAGE_NAME> bash
