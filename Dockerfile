# Use the official Ubuntu image as a base
FROM ubuntu:20.04

# Set the GitHub runner version
ARG RUNNER_VERSION="2.283.3"

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip

# Create a user for the runner
RUN useradd -m runner

# Switch to the runner user
USER runner

# Set up the GitHub Actions runner
RUN mkdir /home/runner/actions-runner && cd /home/runner/actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Copy the start script
COPY start.sh /home/runner/actions-runner/start.sh

# Set the entrypoint
ENTRYPOINT ["/home/runner/actions-runner/start.sh"]
