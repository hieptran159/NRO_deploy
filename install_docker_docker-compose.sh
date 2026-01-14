#!/bin/bash
set -e

echo "=== Cập nhật hệ thống ==="
sudo apt update -y
sudo apt upgrade -y

echo "=== Gỡ bỏ phiên bản Docker cũ (nếu có) ==="
sudo apt remove -y docker docker-engine docker.io containerd runc || true

echo "=== Cài đặt gói phụ thuộc ==="
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

echo "=== Thêm Docker GPG key ==="
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "=== Thêm repository Docker ==="
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Cập nhật danh sách gói ==="
sudo apt update -y

echo "=== Cài đặt Docker Engine và Containerd ==="
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Kích hoạt và khởi động Docker ==="
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Thêm quyền cho user hiện tại ==="
sudo usermod -aG docker $USER

echo "=== Cài đặt Docker Compose độc lập (binary) ==="
DOCKER_COMPOSE_VERSION="2.27.0"
sudo curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

echo "=== Kiểm tra phiên bản Docker và Compose ==="
docker --version
docker-compose --version

echo "=== ✅ Cài đặt hoàn tất! ==="
echo "👉 Hãy đăng xuất hoặc reboot để kích hoạt quyền docker group."
