#!/bin/bash

# Cài đặt gnome-terminal
sudo apt install gnome-terminal -y

# Cập nhật danh sách gói
sudo apt-get update

# Cài đặt các gói phụ thuộc cho Docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Thêm GPG key và repo Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Cập nhật danh sách gói
sudo apt update

# Kiểm tra gói Docker
sudo apt-cache policy docker-ce

# Cài đặt Docker
sudo apt install docker-ce -y

# Cài đặt NVIDIA Container Toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Kích hoạt experimental mode
sudo sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Cập nhật danh sách gói
sudo apt-get update

# Cài đặt NVIDIA Container Toolkit
sudo apt-get install -y nvidia-container-toolkit

# Cấu hình runtime NVIDIA cho Docker
sudo nvidia-ctk runtime configure --runtime=docker

# Thêm user vào group Docker
sudo usermod -aG docker $USER

# Khởi động lại Docker
sudo systemctl restart docker
