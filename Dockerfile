
FROM ubuntu:latest

# Install Dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    libtool \
    glib-2.0

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Initialize the build system
RUN autoreconf --install

# Configure the project using environment variables
RUN ./configure $CONFIG_OPTIONS

# Compile the project
RUN make