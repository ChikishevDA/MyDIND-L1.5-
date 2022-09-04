FROM debian:stable
# Install packs
RUN apt update && apt install -y \ 
ca-certificates \
curl \
gnupg \
lsb-release
# Set up the repository
RUN set -x \
&& mkdir  -p /etc/apt/keyrings \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null 
# Install Docker Engine
RUN set -x \
&& apt-get update && apt-get install -y \ 
docker-ce \ 
docker-ce-cli \ 
containerd.io \
docker-compose-plugin
WORKDIR /usr/local/src
CMD [ "dockerd" ]
EXPOSE 80 443