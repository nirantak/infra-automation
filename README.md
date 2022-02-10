# rpi-setup

> _Ansible playbooks to setup dev environments and home servers_

- [rpi-setup](#rpi-setup)
  - [Installation](#installation)
  - [Playbooks](#playbooks)
    - [rpi](#rpi)
    - [macOS](#macos)
  - [References](#references)

## Installation

```bash
git clone https://github.com/nirantak/rpi-setup.git
cd rpi-setup
python3 -m venv .venv
source .venv/bin/activate
pip install -U -r requirements.txt
ansible-galaxy collection install -r requirements.yml

# To set up pre-commit hooks, required for contributing code, run:
pre-commit install --install-hooks --overwrite
```

Update the following files to your liking:

- `inventory.ini` (replace IP address with your server's IP, or use `127.0.0.1` and add `connection=local` at the end if you're running it on the machine you're setting up).
- `config.yml`

## Playbooks

### rpi

> _Raspberry Pi setup and config for all things Internet_

For backup for Pi-hole at least, in the GUI you can go to Settings > Teleporter and click 'Backup'. To automate it through the console, you can run `pihole -a -t`.

```bash
ansible-playbook main.yml
```

### macOS

> _Mac dev env setup and configuration_

## References

- https://github.com/geerlingguy/internet-pi
- https://github.com/geerlingguy/mac-dev-playbook
