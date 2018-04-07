# docker-bastion

Docker image for SSH bastion server

```sh
docker run -d -p 10222:22 -e 'AUTHORIZED_KEYS=hoge' bastion:latest
ssh -p 10222 -i hoge/id_rsa sshguest@localhost
```
