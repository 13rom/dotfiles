# dotfiles

## Pre-requisites

Install the packages:

```shell
sudo apt update && sudo apt install stow zsh
```

Install zap:

```shell
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
```

## Deploy

```shell
curl -L https://raw.githubusercontent.com/13rom/dotfiles/master/download.sh | bash
```