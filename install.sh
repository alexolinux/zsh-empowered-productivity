#!/bin/bash

ZSHRC_FILE="${HOME}/.zshrc"
OH_MYZSH="${HOME}/.oh-my-zsh"
ZSH_PLUGINS_DIR="${OH_MYZSH}/plugins"
ZSH_PLUGINS=(
    zsh-syntax-highlighting
    zsh-autosuggestions
)

check_comm() {
    if [ "$?" -ne 0 ]; then
        echo "Command failed. Script interrupted."
        exit 1
    fi
}

install_zsh() {
    if command -v zsh &> /dev/null; then
        echo "Zsh is already installed."
    else
        echo "Installing Zsh..."
        if [ -f "/etc/debian_version" ]; then
            sudo apt update && sudo apt install -y zsh
        elif [ -f "/etc/redhat-release" ]; then
            sudo yum install -y zsh
        else
            echo "Unsupported distribution. Please install Zsh manually."
            exit 1
        fi
        check_comm
    fi
}

clear && echo "#-- ----------|| ZSH SHELL Configuration ||---------- --#"

install_zsh

if command -v chsh &> /dev/null; then    
    echo "Changing user SHELL to ZSH using chsh..."
    zsh_path=$(command -v zsh)
    sudo chsh -s "$zsh_path" "$USER"
else
    echo "Failed to change User SHELL. Check if ZSH is available."
    exit 1
fi

echo "Checking OHMyZSH Installation..."
if [ ! -d "${OH_MYZSH}" ]; then
    echo "Installing OHMyZSH..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    check_comm
fi

mkdir -p "${ZSH_PLUGINS_DIR}"

echo "Checking/Installing ZSH plugins..."
for plugin in "${ZSH_PLUGINS[@]}"; do
    if [ ! -d "${ZSH_PLUGINS_DIR}/$plugin" ]; then
        echo "Installing $plugin..."
        git clone https://github.com/zsh-users/$plugin.git "${ZSH_PLUGINS_DIR}/$plugin"
        check_comm
    fi
done

echo "Adding New plugins to the ZSH Environment..."
ZSH_PLUGINS_STRING=""
for plugin in "${ZSH_PLUGINS[@]}"; do
    ZSH_PLUGINS_STRING+="  $plugin\n"
done

sed -i.bak "/^plugins=(/{
    s/^plugins=(/&\n$ZSH_PLUGINS_STRING/
    s/\n\n/\n/g
}" "${ZSHRC_FILE}"

check_comm
echo "New plugins added to ${ZSHRC_FILE}. A backup of the original file is saved as ${ZSHRC_FILE}.bak."

echo "Migrating to PowerLevel10K..."
if [ ! -d "${OH_MYZSH}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${OH_MYZSH}/themes/powerlevel10k"
fi

check_comm

sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC_FILE"

echo "Script completed successfully! Restart/Reload your SHELL Session for the changes to take effect. Enjoy It!"
