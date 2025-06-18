## 🐳 Aktiver GPU BoostBuilds: Instantly Deploy Ultra-Slim Python AI Containers

## 🚀 Description:

A flexible, ultra-optimized Docker image built on Python slim (3.8–3.13) and fully configurable NVIDIA CUDA (10.x–12.x) with cuDNN support. Ideal for GPU-powered AI/ML workloads, from rapid experimentation to production-grade model training and inference. Easily extendable via Micromamba, customizable CUDA/cuDNN versions, and ready-to-deploy PyTorch integration.

Base container starts @ `~2.85GiB`, perfect for streamlined deployments!

## ⚡ Features:

* Lightweight Python slim images (versions 3.8–3.13)
* Auto builds for ARM/IoT, x86, Intel/AMD.
* Flexible NVIDIA CUDA support (10.x–12.x)
* Customizable cuDNN installations (8.x–9.x)
* Optional Micromamba integration for fast environment management
* Official CUDA/cuDNN installation from NVIDIA sources
* PyTorch optimized and pre-configured for CUDA acceleration
* Easy runtime GPU selection (single, multiple, or all GPUs)
* Compact, efficient images (\~2.85GiB), perfect for streamlined deployments
* Pre-set environment variables for immediate use (`PATH`, `LD_LIBRARY_PATH`, `CUDA_HOME`)
* Docker Hub ready (with simple tagging and push instructions)
* Robust Python dependency management (e.g., precise NumPy version control)
* Clear and modular Dockerfile for rapid customization and extension

#### Images are publicly avail at: [Aktiver's DockerHub](https://hub.docker.com/repositories/aktiver)

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
