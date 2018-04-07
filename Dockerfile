FROM alpine:edge
LABEL maintainer "rot1024 <aayhrot@gmail.com>"

RUN apk add --update --no-cache openssh \
  && sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config \
  && sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
  && adduser -D sshguest \
  && echo "sshguest:sshguest" | chpasswd \
  && mkdir -m 700 -p /home/sshguest/.ssh \
  && touch /home/sshguest/.ssh/authorized_keys \
  && chmod 600 /home/sshguest/.ssh/authorized_keys \
  && chown -R sshguest:sshguest /home/sshguest/.ssh

ADD docker-entrypoint.sh /usr/local/bin

RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key

EXPOSE 22
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
