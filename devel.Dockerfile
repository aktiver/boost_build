# syntax=docker/dockerfile:1
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}-slim

# Install build deps (only what's needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget build-essential libxml2 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install official CUDA toolkit silently
ARG CUDA_VERSION=11.6.0
ARG CUDA_RUNFILE=cuda_11.6.0_510.39.01_linux.run
RUN wget -q https://developer.download.nvidia.com/compute/cuda/${CUDA_VERSION}/local_installers/${CUDA_RUNFILE} && \
    sh ${CUDA_RUNFILE} --silent --toolkit --installpath=/opt/cuda --override && \
    rm ${CUDA_RUNFILE}

# Copy your local cuDNN .deb file into the container
COPY cudnn-local-repo-debian11-8.6.0.163_1.0-1_amd64.deb /tmp/

RUN dpkg -i /tmp/cudnn-local-repo-debian11-8.6.0.163_1.0-1_amd64.deb && \
    apt-get update --allow-insecure-repositories && \
    apt-get install -y --allow-unauthenticated libcudnn8 libcudnn8-dev && \
    rm /tmp/cudnn-local-repo-debian11-8.6.0.163_1.0-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables (CUDA)
ENV PATH=/opt/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH=/opt/cuda/lib64:${LD_LIBRARY_PATH}
ENV CUDA_HOME=/opt/cuda

# Install PyTorch with CUDA 11.6 support (optional but common)
RUN pip install --no-cache-dir \
    torch==1.13.0+cu116 torchvision==0.14.0+cu116 torchaudio==0.13.0 \
    --extra-index-url https://download.pytorch.org/whl/cu116

# Final cleanup (remove unnecessary tools)
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["python3"]
