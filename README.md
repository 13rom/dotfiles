# dotfiles

## Pre-requisites

Install the packages:

```shell
sudo apt update && sudo apt install stow zsh
```

Install auxiliary programs:

```shell
sudo apt install bat
wget https://github.com/lsd-rs/lsd/releases/download/v1.1.2/lsd-musl_1.1.2_amd64.deb
sudo apt install ./lsd-musl_1.1.2_amd64.deb
rm ./lsd-musl_1.1.2_amd64.deb
```

Install zap:

```shell
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
```

## Deploy

Move bashrc file away:

```shell
mv ~/.bashrc ~/.bashrc.original
```

Deploy dotfiles:

```shell
curl -L https://raw.githubusercontent.com/13rom/dotfiles/master/download.sh | bash
```
