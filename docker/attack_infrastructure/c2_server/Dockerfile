FROM parrotsec/core:latest

# Update the package list and install necessary packages
RUN apt-get update && apt-get install -y curl

# Build-time Sliver version variable with default value
ARG SLIVER_VERSION=v1.5.0

# Download and install Sliver server
RUN curl -LO https://github.com/BishopFox/sliver/releases/download/${SLIVER_VERSION}/sliver-server_linux && \
    chmod +x sliver-server_linux && \
    mv sliver-server_linux /usr/local/bin/sliver-server

# Expose the default Sliver port
EXPOSE 8888

# Set the entrypoint to the Sliver server
ENTRYPOINT ["sliver-server"]
