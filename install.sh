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

clear && echo "#-- ----------|| ZSH SHELL Configuration ||---------- --#"

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

if [ ! -d "${ZSH_PLUGINS_DIR}" ]; then
    mkdir -p "${ZSH_PLUGINS_DIR}"
fi

echo "Checking/Installing ZSH plugins..."

if [ ! -d "${ZSH_PLUGINS_DIR}/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_PLUGINS_DIR}/zsh-autosuggestions"
    check_comm
fi

if [ ! -d "${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_PLUGINS_DIR}/zsh-syntax-highlighting"
    check_comm
fi

echo "ZSH Plugins downloaded successfully! \o/\o/"

echo "Adding New plugins to the ZSH Environment..."

ZSH_PLUGINS_STRING=""
for plugin in "${ZSH_PLUGINS[@]}"; do
    ZSH_PLUGINS_STRING+="  $plugin\n"
done

sed -i.bak "/^plugins=(/{
    s/^plugins=(/&\n$ZSH_PLUGINS_STRING/
    s/\n\n/\n/g  # Remove any extra new lines
}" "${ZSHRC_FILE}"

check_comm

echo "New plugins added to ${ZSHRC_FILE}. A backup of the original file is saved as ${ZSHRC_FILE}.bak."

echo "Migrating to PowerLevel10K..."

if [ ! -d "${OH_MYZSH}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${OH_MYZSH}/themes/powerlevel10k"
fi

check_comm

echo "Changing ZSH Theme..."
sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"

echo "Script completed successfully! \o/\o/ Reload you SHELL Environment to make effect."
echo "Apply the changes executing: zsh"
