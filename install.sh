#!/bin/bash

GROUP_NAME="devops"
GROUP_SUDO="/etc/sudoers.d/devops"
ZSHRC_FILE="${HOME}/.zshrc"
ZSH_PLUGINS=(
    zsh-syntax-highlighting
    zsh-autosuggestions
)

# Create a temporary file to hold the modified content
TEMP_FILE=$(mktemp)

# Detect OS type
OS_TYPE=$(uname -s)

# Check package manager
get_package_manager() {
    if [[ "$OS_TYPE" == "Linux" ]]; then
        if command -v apt &> /dev/null; then
            echo "apt"
        elif command -v yum &> /dev/null; then
            echo "yum"
        elif command -v dnf &> /dev/null; then
            echo "dnf"
        else
            echo "Unsupported package manager"
            exit 1
        fi
    elif [[ "$OS_TYPE" == "Darwin" ]]; then
        if command -v brew &> /dev/null; then
            echo "brew"
        else
            echo "brew_not_installed"
        fi
    else
        echo "Unsupported operating system"
        exit 1
    fi
}

# Install Homebrew if not present (macOS only)
install_homebrew() {
    echo "Checking Homebrew installation..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed."
    fi
}

# Function to install packages based on package manager
install_packages() {
    local package_manager=$1

    case $package_manager in
        "apt")
            sudo apt update
            sudo apt upgrade -y
            sudo apt install -y git gcc g++ autoconf make automake wget curl passwd vim-common openssl jq zsh
            ;;
        "yum")
            sudo yum update -y
            sudo yum install -y git gcc gcc-c++ autoconf make automake wget curl util-linux vim-common openssl jq zsh
            ;;
        "dnf")
            sudo dnf update -y
            sudo dnf install -y git gcc gcc-c++ autoconf make automake wget curl util-linux-user vim-common openssl jq zsh
            ;;
        "brew")
            brew update
            brew install git gcc autoconf automake wget curl vim openssl jq zsh
            ;;
        *)
            echo "Unsupported package manager"
            exit 1
            ;;
    esac
}

# Determine package manager
package_manager=$(get_package_manager)

if [[ "$package_manager" == "brew_not_installed" ]]; then
    install_homebrew
    package_manager="brew"
fi

echo "Update system"
# Install required packages based on package manager
install_packages $package_manager

if [[ "$OS_TYPE" == "Linux" ]]; then
    # Check if the group exists
    if grep -q "^$GROUP_NAME:" /etc/group; then
        echo "Group $GROUP_NAME already exists."
    else
        # Group does not exist, create it
        echo "Group $GROUP_NAME does not exist. Creating..."
        sudo groupadd -g 2024 $GROUP_NAME
        echo "Group $GROUP_NAME created."
    fi

    # Check if the user is already a member of the group
    if ! groups $USER | grep -q "\b$GROUP_NAME\b"; then
        # User is not a member of the group, so add them
        sudo usermod -aG $GROUP_NAME $USER
        echo "$USER has been added to the group $GROUP_NAME."
    else
        echo "$USER is already a member of the group $GROUP_NAME."
    fi

    echo "Checking sudoers file for devops group"
    if [ -e "$GROUP_SUDO" ]; then
        echo "The file $GROUP_SUDO exists."
    else
        echo "%devops ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/devops
        echo "Sudo has been applied for the $GROUP_NAME group."
    fi
fi

echo "ZSH Installation"
# Install ZSH and set it as the default shell if not installed
if ! command -v zsh &> /dev/null; then
    echo "ZSH not found. Installing..."
    install_packages $package_manager
fi

if command -v chsh &> /dev/null; then
    echo "Changing user SHELL to ZSH using chsh..."
    zsh_path=$(command -v zsh)
    
    if ! grep -q "$zsh_path" /etc/shells; then
        echo "$zsh_path" | sudo tee -a /etc/shells
    fi

    chsh -s "$zsh_path"
else
    echo "chsh command not available. Please manually change your shell to ZSH."
fi

echo "Checking OHMyZSH Installation..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing OHMyZSH..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Checking PowerLevel10K Installation..."
if [ ! -d "$HOME/.oh-my-zsh/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/themes/powerlevel10k"
fi

echo "Changing ZSH Theme..."
sed -i '' 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC_FILE"

plugins_dir="$HOME/.oh-my-zsh/plugins"
mkdir -p "$plugins_dir"

echo "Checking/Installing ZSH plugins..."
for plugin in "${ZSH_PLUGINS[@]}"; do
    if [ ! -d "$plugins_dir/$plugin" ]; then
        echo "Installing $plugin..."
        git clone https://github.com/zsh-users/$plugin.git "$plugins_dir/$plugin"
    fi
done

echo "Backing up ZSH User file configuration..."
cp -p "${ZSHRC_FILE}" "${ZSHRC_FILE}.save" 

echo "Appending new ZSH plugins..."

inside_plugins_array=false

while IFS= read -r line; do
    if [[ "$line" =~ ^plugins=\( ]]; then
        inside_plugins_array=true
        echo "$line" >> "$TEMP_FILE"
    elif [[ "$line" =~ ^\) && $inside_plugins_array == true ]]; then
        for plugin in "${ZSH_PLUGINS[@]}"; do
            echo "    $plugin" >> "$TEMP_FILE"
        done
        echo "$line" >> "$TEMP_FILE"
        inside_plugins_array=false
    else
        echo "$line" >> "$TEMP_FILE"
    fi
done < "$ZSHRC_FILE"

mv "$TEMP_FILE" "$ZSHRC_FILE"

echo "New plugins added successfully."
