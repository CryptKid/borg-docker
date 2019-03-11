FROM ubuntu:rolling
RUN apt update
RUN apt-get dist-upgrade -y
RUN apt-get install openssh-server borgbackup borgbackup-doc -y
COPY ssh/* /etc/ssh/ 
RUN mkdir /backups/
RUN useradd -ms /bin/bash borg
RUN chown borg:borg /backups/ -Rc
RUN groupadd ssh-user
RUN usermod borg -aG ssh-user
EXPOSE 65000
USER borg
RUN mkdir ~/.ssh/
RUN ln -s /home/borg/.ssh/ /backups/ssh
CMD ["/usr/sbin/sshd", "-D"]
