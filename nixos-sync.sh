#!/usr/bin/env bash

declare -A CONFIG_FILES=(
    ["configuration.nix"]="/etc/nixos/configuration.nix"
    ["hardware-configuration.nix"]="/etc/nixos/hardware-configuration.nix"
    ["flake.nix"]="/etc/nixos/flake.nix"
    ["flake.lock"]="/etc/nixos/flake.lock"
    ["profile"]="/home/george/.profile"
    ["bashrc"]="/home/george/.bashrc"
    ["cargo/config.toml"]="/home/george/.cargo/config.toml"
    ["gitconfig"]="/home/george/.gitconfig"
    ["gitconfig-personal"]="/home/george/.gitconfig-personal"
    ["ssh/config"]="/home/george/.ssh/config"
)

save_configs() {
    echo "Saving configs to current directory..."
    for local_file in "${!CONFIG_FILES[@]}"; do
        target_file="${CONFIG_FILES[$local_file]}"
        
        if [ -f "$target_file" ]; then
	    mkdir -p "$(dirname "$local_file")"
            cp "$target_file" "./$local_file"
	    git add "./$local_file"
            echo "Saved $target_file => ./$local_file"
        else
            echo "Warning: $target_file does not exist. Skipping."
        fi
    done
    git commit -m "NixOS Backup: $(date)"
}

load_configs() {
    echo "Loading configs from current directory..."
    for local_file in "${!CONFIG_FILES[@]}"; do
        target_file="${CONFIG_FILES[$local_file]}"
        
        # Check if the local backup actually exists
        if [ ! -f "./$local_file" ]; then
            echo "Warning: ./$local_file not found in current directory. Skipping."
            continue
        fi
        
        # Check if files are identical
        if [ -f "$target_file" ] && cmp -s "./$local_file" "$target_file"; then
            echo "Skipped $local_file: files are identical."
            continue
        fi
        
        # Files differ (or system file doesn't exist yet), ask for confirmation
        read -p "Overwrite $target_file with ./$local_file? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
	    mkdir -p "$(dirname "$local_file")"
            # Automatically use sudo if the destination isn't writable by the user
            if [ -w "$(dirname "$target_file")" ] && { [ ! -e "$target_file" ] || [ -w "$target_file" ]; }; then
                cp "./$local_file" "$target_file"
            else
                echo "Requires elevated permissions..."
                sudo cp "./$local_file" "$target_file"
            fi
            echo "Copied ./$local_file => $target_file"
        else
            echo "Skipped $local_file."
        fi
    done
}

# Main logic to handle the arguments
case "$1" in
    save)
        save_configs
        ;;
    load)
        load_configs
        ;;
    sync)
	load_configs
	save_configs
	;;
    *)
        echo "Usage: $0 {save|load}"
        exit 1
        ;;
esac

