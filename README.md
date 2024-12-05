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
- Adds useful plugins and themes.
- Sets up a custom `zshrc` file for an optimal developer experience.

### DevOps Group Management (Linux Only)

- Creates a `devops` user group (if it doesn't already exist).
- Adds the current user to the `devops` group.
- Grants passwordless `sudo` privileges to the `devops` group by modifying `/etc/sudoers.d`.

| Feel free to change the group to be used in the script `GROUP_NAME`:

```shell
GROUP_NAME="my-custom-group"
```

## System Compatibility

This script is designed to work on the following operating systems:

### Supported Operating Systems

1. **Linux Distributions:**
   - Ubuntu/Debian-based systems (`apt`)
   - RHEL/CentOS (`yum`)
   - Fedora (`dnf`)

   _Note: DevOps group creation and sudo management are only available on Linux._

2. **macOS:**
   - Compatible with macOS versions that support [Homebrew](https://brew.sh).

### Requirements

- **Linux:**
  - A `sudo`-enabled user account.
  - Internet connection for installing dependencies.
  
- **macOS:**
  - Homebrew installed (or the script will install it for you).

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

4. Restart your terminal to enjoy your new ZSH environment.

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
* [Oh My Zsh plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/plugins)

## Author: Alex Mendes

<https://www.linkedin.com/in/mendesalex>

