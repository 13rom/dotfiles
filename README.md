# dotfiles

## Pre-requisites

Install the packages:

```shell
sudo apt update && sudo apt install git zsh stow direnv
```

Install brew:

```shell
sudo apt install build-essential procps curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install auxiliary programs:

```shell
brew install fzf zoxide eza bat
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
