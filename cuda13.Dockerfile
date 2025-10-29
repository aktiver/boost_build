# syntax=docker/dockerfile:1
ARG PYTHON_VERSION=3.14.0
FROM python:${PYTHON_VERSION}-slim

# Install build deps (only what's needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget build-essential libxml2 ca-certificates python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install official CUDA toolkit silently
ARG CUDA_VERSION=13.0.2
ARG CUDA_RUNFILE=cuda_13.0.2_580.95.05_linux.run
RUN wget -q https://developer.download.nvidia.com/compute/cuda/${CUDA_VERSION}/local_installers/${CUDA_RUNFILE} && \
    sh ${CUDA_RUNFILE} --silent --toolkit --installpath=/opt/cuda --override && \
    rm ${CUDA_RUNFILE}

# Copy your local cuDNN .deb file into the container
# Copy your local cuDNN .deb file into the container
COPY ./cudnn-local-repo-debian12-9.14.0_1.0-1_amd64.deb /tmp/

RUN dpkg -i /tmp/cudnn-local-repo-debian12-9.14.0_1.0-1_amd64.deb && \
    apt-get update --allow-insecure-repositories && \
    apt-get install -y --allow-unauthenticated cudnn9-cuda-13 && \
    rm /tmp/cudnn-local-repo-debian12-9.14.0_1.0-1_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables (CUDA)
ENV PATH=/opt/cuda/bin:${PATH}

ENV LD_LIBRARY_PATH=/opt/cuda/lib64

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64:/usr/local/cuda/compat

ENV CUDA_HOME=/opt/cuda

RUN pip uninstall -y numpy || true && \
    pip install --no-cache-dir numpy==2.3.4
    
# Install PyTorch with CUDA 13 support (optional but common)
RUN pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu130


# Final cleanup (remove unnecessary tools)
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["python3"]
