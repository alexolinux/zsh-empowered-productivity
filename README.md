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

- Automatically installs and configures ZSH and Oh My Zsh.
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

## Author: Alex Mendes

<https://www.linkedin.com/in/mendesalex>
