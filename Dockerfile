FROM scratch
ADD archlinux.tar /
ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]

# Install all required packages
CMD bash install_deps.sh