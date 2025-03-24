FROM ubuntu:latest

# Install Dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    libtool \
    glib-2.0 \
    make \
    g++

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Define build argument for configure options
ARG CONFIG_OPTIONS="--with-syslog --with-glib --without-cutils --with-dummy_diag --with-are_on_apps"
ARG OUTPUT_DIR="/app/output"

# Initialize, configure, and compile the project
RUN autoreconf --install && \
    ./configure $CONFIG_OPTIONS && \
    make && \
    make DESTDIR=$OUTPUT_DIR install

# Set the entrypoint to a shell
ENTRYPOINT ["/bin/bash"]
