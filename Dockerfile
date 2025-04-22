FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    software-properties-common \
    libgl1-mesa-dev \
    libx11-dev \
    libxcursor-dev \
    libxrandr-dev \
    libxinerama-dev \
    libxi-dev \
    cmake \
    pkg-config \
    unzip \
    gpg

RUN curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/kitware.gpg && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ jammy main' && \
    apt-get update && \
    apt-get install -y kitware-archive-keyring cmake

RUN git clone https://github.com/raysan5/raylib.git /opt/raylib && \
    cd /opt/raylib && \
    mkdir build && cd build && \
    cmake -DBUILD_EXAMPLES=OFF -DCMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$(nproc) && make install

WORKDIR /app

COPY . /app

RUN find . -name '*.cpp' -exec g++ -c -I/usr/local/include {} \; && \
    g++ -o game *.o -L/usr/local/lib -lraylib -lGL -lm -lpthread -ldl -lrt -lX11

CMD ["./game"]

