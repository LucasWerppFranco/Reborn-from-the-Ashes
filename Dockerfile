FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    software-properties-common \
    libgl1-mesa-dev \
    libx11-dev \
    libxcursor-dev \
    libxi-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxxf86vm-dev \
    libxext-dev \
    libasound2-dev \
    libpulse-dev \
    libopenal-dev \
    libvorbis-dev \
    libudev-dev \
    libdrm-dev \
    pkg-config \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/kitware.gpg && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ jammy main' && \
    apt-get update && \
    apt-get install -y cmake && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/raysan5/raylib.git /opt/raylib && \
    cd /opt/raylib && mkdir build && cd build && \
    cmake -DBUILD_EXAMPLES=OFF .. && \
    make -j$(nproc) && make install

WORKDIR /app

COPY . /app

CMD g++ -o game main.cpp -lraylib -lGL -lm -lpthread -ldl -lrt -lX11 && ./game
