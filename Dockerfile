# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3.8 \
    python3.8-dev \
    python3-pip \
    python3-distutils \
    curl \
    openjdk-8-jdk \
    libatomic1 \
    libjpeg-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.8 as the default python version
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    update-alternatives --set python3 /usr/bin/python3.8 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1

# Upgrade pip
RUN python3 -m pip install --upgrade pip

# Install Python packages
RUN pip3 install numpy==1.19.5 pillow==8.3.2 scipy==1.5.4 protobuf==3.19.4 tensorflow==2.5.0

# Set up working directory
WORKDIR /app

# Set environment variables
ENV SNPE_ROOT=/app/qual
ENV PATH="${SNPE_ROOT}/bin/x86_64-linux-clang:${SNPE_ROOT}/bin:${PATH}"
ENV LD_LIBRARY_PATH="${SNPE_ROOT}/lib/x86_64-linux-clang:${SNPE_ROOT}/lib:/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}"
ENV PYTHONPATH="${SNPE_ROOT}/lib/python:${SNPE_ROOT}/lib/python/qti/aisw/converters/common/linux-x86_64:${PYTHONPATH}"

# Set the default command
CMD ["/bin/bash"]