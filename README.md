# zsh-empowered-productivity 🚀

Enhancing Productivity with ZSH

-------------------------------------------

After testing several Linux environments, I finally found one that fulfills my workday needs.
So, I decided create this repository containing a fully automated setup script for a powerful, productivity-enhancing ZSH shell environment.
Featuring:

- [PowerLevel10K](https://github.com/romkatv/powerlevel10k) for a stunning and informative shell prompt.

- Plugins like [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) and [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) to boost efficiency.

## Features

### ZSH Environment Setup

- Automatically installs and configures ZSH and **[Oh My Zsh](https://ohmyz.sh/)**.
- Adds useful plugins and PowerLevel10K Theme.
- Sets up a custom `zshrc` file for an optimal developer experience.

## System Compatibility

*This script is designed to work on ZSH Shell Environment*

### Requirements

**Packages**

- git
- curl

-------------------------------------------

## Installation

1. Clone the repository:

  ```shell
  git clone https://github.com/alexolinux/zsh-empowered-productivity.git
  ```

2. Go to the project folder and add execution permissions to the setup script:

  ```shell
  cd zsh-empowered-productivity
  chmod +x install.sh
  ```

3. Run the installer:

  ```shell
  ./install.sh
  ```

4. You must reload you SHELL Session an use `zsh` as default SHELL:

```shell
zsh
```

**NOTE:** After migrating to **PowerLevel10K**, a wizard will appear with steps to customize your new environment. Please make your selections according to your preferences. 

## Extra Tips

If you (just like me :) ) are a frequent user of `kubectl` for managing and controlling Kubernetes environments, this section provides a script to add my favorite ZSH Plugins for **K8s**:

* kubectl
* kube-aliases
* kubectl-autocomplete

Here is the link to the Script: [kube-env.sh](https://gist.github.com/alexolinux/12e41c6df5c78f745f65b438ce6e0c73)

  _Note: Follow the same process as the Installation Section above._

*Install them and notice the difference! ;)*

## References

* [ZSH](https://wiki.zshell.dev/docs/code)
* [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh/wiki)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k)
* [Oh My Zsh plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/plugins)

## Author: Alex Mendes

<https://www.linkedin.com/in/mendesalex>
