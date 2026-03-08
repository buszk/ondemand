FROM ubuntu:24.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install base system and development tools
RUN apt-get update && apt-get install -y \
    # Build tools
    build-essential \
    cmake \
    make \
    gcc \
    g++ \
    clang \
    ninja-build \
    # Version control
    git \
    subversion \
    # Languages - Python
    python3 \
    python3-pip \
    python3-venv \
    # Languages - Go
    golang \
    # Languages - Rust
    rustc \
    cargo \
    # Languages - Java
    openjdk-17-jdk \
    maven \
    # Database clients
    postgresql-client \
    mysql-client \
    redis-tools \
    # Container tools
    docker.io \
    # Text editors and utilities
    vim \
    nano \
    emacs-nox \
    htop \
    tmux \
    curl \
    wget \
    unzip \
    zip \
    tar \
    rsync \
    # SSH
    openssh-server \
    openssh-client \
    # Misc
    sudo \
    locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create developer user
RUN useradd -m -s /bin/bash -G sudo,docker developer
RUN echo 'developer:developer' | chpasswd

# Configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN echo 'developer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# SSH requires this
RUN echo "PermitUserEnvironment no" >> /etc/ssh/sshd_config

# Install Claude Code CLI and happy-coder
RUN npm install -g @anthropic-ai/claude-code happy-coder

# Create Claude settings directory
RUN mkdir -p /home/developer/.claude && chown -R developer:developer /home/developer/.claude

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
