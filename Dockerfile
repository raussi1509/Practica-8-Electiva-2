
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3

RUN useradd -m -s /bin/bash ansible

RUN echo "ansible:ansible" | chpasswd

RUN echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible

RUN chmod 440 /etc/sudoers.d/ansible

RUN mkdir -p /run/sshd

RUN printf 'PasswordAuthentication yes\n' > /etc/ssh/sshd_config.d/10-ansible-lab.conf

EXPOSE 22

CMD ["sh", "-c", "ssh-keygen -A && exec /usr/sbin/sshd -D"]
