base build is only 2.85GiB in size using Python 3.x slim and CUDA 10x to 12x

docker build -f <DOCKERFILE_NAME> -t <IMAGE_NAME>:latest .

docker run --gpus '"device=0"' -it --rm  <IMAGE_NAME> bash


images are avail at: https://hub.docker.com/repositories/aktiver

---

To use all GPUs or specific GPU indices with Docker Compose:

### Docker/Docker Compose Configuration (all GPUs):

```bash
docker run --gpus '"device=0"' -it --rm <IMAGE_NAME> bash
```

For multiple GPUs:

```bash
docker run --gpus '"device=0,2"' -it --rm <IMAGE_NAME> bash
```

To use all GPUs:

```bash
docker run --gpus all -it --rm <IMAGE_NAME> bash
```

This syntax is standard and directly controls GPU visibility at runtime for your container.

To use all GPUs:

```yaml
services:
  your_service:
    image: your_image
    runtime: nvidia  # Enables NVIDIA GPU support
    ipc: host
    deploy:
      resources:
        reservations:
          devices:
            - capabilities: [gpu]
```

or (simplified version):

```yaml
services:
  your_service:
    image: your_image
    runtime: nvidia  # Enables NVIDIA GPU support
    ipc: host
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
```

---

### Selecting specific GPUs by index:

To select specific GPUs by index, set the environment variable:

```yaml
services:
  your_service:
    image: your_image
    runtime: nvidia  # Enables NVIDIA GPU support
    ipc: host
    environment:
      - NVIDIA_VISIBLE_DEVICES=0,2 # GPUs with indices 0 and 2
```

This will expose only the selected GPUs (by index) to the container.

----

### Push your Docker image to Docker Hub:


### ✅ **1. Log into Docker Hub**

Run the following command:

```bash
docker login -u your_dockerhub_username
```

You'll then be prompted to enter your Docker Hub **password or token**.

---

### ✅ **2. Tag your Docker Image**

If your image isn't already tagged properly, tag it with your Docker Hub username and repository name:

```bash
docker tag your-image-name:latest your_dockerhub_username/your-repo-name:latest
```

For example:

```bash
docker tag cuda-pytorch:11.6 johndoe/cuda-pytorch:11.6
```

---

### ✅ **3. Push the Image**

Now push your image to Docker Hub:

```bash
docker push your_dockerhub_username/your-repo-name:latest
```

Example:

```bash
docker push johndoe/cuda-pytorch:11.6
```

---

### 🎯 **Summary of Steps:**

```bash
docker login -u your_dockerhub_username
docker tag your-local-image your_dockerhub_username/repository-name:tag
docker push your_dockerhub_username/repository-name:tag
```

Your image is now available on Docker Hub.
