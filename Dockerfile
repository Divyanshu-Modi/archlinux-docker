FROM archlinux:base-devel

USER root

ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]

# Install all required packages
COPY install_deps.sh /tmp/
RUN bash /tmp/install_deps.sh

# Install all required packages
COPY arch_strip.sh /tmp/
RUN bash /tmp/arch_strip.sh
