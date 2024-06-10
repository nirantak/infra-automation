# Setup Scripts

Bash scripts here are yet to be migrated to Ansible.

## Setup Xcode

```shell
xcode-select --install
# Install Xcode from the App store
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
# Check path and version
xcode-select -p
xcodebuild -version
# On M1 Macs
softwareupdate --install-rosetta
```

## Configuring GPG sign key

Run the following to add a config line to file `~/.gnupg/gpg-agent.conf`:

```shell
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```

## Custom Keybindings

```bash
mkdir -p ~/Library/KeyBindings

# Set Option+4 to the Rupee symbol "₹"
echo '{ "~4" = (insertText:, "₹"); }' >> ~/Library/KeyBindings/DefaultKeyBinding.dict
```

## Install from the App Store

- Xcode
- NordVPN
