FROM ghcr.io/ublue-os/ucore:latest

# Define the RPM packages to layer directly into the immutable base system.
# These are essential for your writerdeck's core functionality and minimal graphical environment.
RUN rpm-ostree install \
    cage \
    ptyxis \
    neovim \
    zsh \
    git \
    rsync \
    openssh-clients \
    rclone \
    xorg-x11-server-Xwayland \
    mesa-libGL \
    mesa-dri-drivers \
    xorg-x11-drv-intel \
    NetworkManager \
    NetworkManager-wifi \
    wpa_supplicant \
    google-noto-sans-mono-fonts && \
    rpm-ostree cleanup -m

# Create a dedicated 'writer' user for the appliance.
# This user will be automatically logged in to the writerdeck session.
# IMPORTANT: Replace 'your_secure_password' with a strong, unique password.
# For a truly secure appliance, consider relying solely on SSH keys for management
# and remove the password setting here (or set an extremely complex one).
RUN useradd -m -s /usr/bin/zsh writer && \
    echo "writer:password" | chpasswd && \
    # Set zsh as the default shell for the root user as well, for consistency
    # if you ever need to access the root shell (e.g., via `podman exec`).
    chsh -s /usr/bin/zsh root

# Copy custom configuration files from your 'config' directory into the image.
# These files define the systemd service for auto-boot and default user dotfiles.
COPY config/etc/systemd/system/writerdeck.service /etc/systemd/system/writerdeck.service
COPY config/etc/skel/.zshrc /etc/skel/.zshrc
COPY config/etc/skel/.config/nvim/init.lua /etc/skel/.config/nvim/init.lua

# Enable the custom systemd service and set it as the default boot target.
# This ensures the system boots directly into your writerdeck environment.
RUN systemctl enable writerdeck.service

# Create a symlink to make writerdeck.service the default boot target.
# This replaces `systemctl set-default` which cannot be run during build.
RUN ln -sf /etc/systemd/system/writerdeck.service /etc/systemd/system/default.target

# Set the default shell for interactive sessions within the container (e.g., `podman exec`).
SHELL ["/usr/bin/zsh", "-c"]

# Set the default working directory for the container.
WORKDIR /home/writer

# Define the entrypoint for the image. When this image is run as a system,
# systemd will be the initial process (PID 1).
CMD ["/usr/sbin/init"]

