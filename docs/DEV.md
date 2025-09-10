# Dev tools

## Docker

```shell
sudo pacman -Sy docker docker-buildx docker-compose
sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"
reboot
docker run hello-world
```

### Google container registry mirror

```shell
echo '{ "registry-mirrors": ["https://mirror.gcr.io"] }' | sudo tee /etc/docker/daemon.json
reboot
```

## Ansible

```shell
pacman -Sy ansible-core
```

## Kubernetes

```shell
pacman -Sy k9s

k9s
```