base build is only 2.85GiB in size using Python 3.x slim and CUDA 10x to 12x

docker build -f <DOCKERFILE_NAME> -t <IMAGE_NAME>:latest .

docker run --gpus '"device=0"' -it --rm  <IMAGE_NAME> bash


images are avail at: https://hub.docker.com/repositories/aktiver
