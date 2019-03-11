FROM ubuntu:rolling
RUN apt update
RUN apt-get dist-upgrade -y
RUN apt-get install openssh-server borgbackup borgbackup-doc -y
COPY ssh/* /etc/ssh/ 
RUN mkdir /backups/
RUN useradd -ms /bin/bash backup
RUN chown backup:backup /backups/ -Rc
RUN groupadd ssh-user
RUN usermod backup -aG ssh-user
USER backup
RUN mkdir ~/.ssh/
RUN ln -s /home/backup/.ssh/ /backups/ssh/
CMD ["sshd -D"]
