base build is only 2.85GiB in size using Python 3.x slim and CUDA 10x to 12x

docker build -f <DOCKERFILE_NAME> -t <IMAGE_NAME>:latest .

docker run --gpus '"device=0"' -it --rm  <IMAGE_NAME> bash


images are avail at: https://hub.docker.com/repositories/aktiver

----------------------------------------------------------------

### Push your Docker image to Docker Hub:

---

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
