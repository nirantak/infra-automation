# Infra Automation

> _Ansible playbooks to setup dev environments and home servers_

- [Infra Automation](#infra-automation)
  - [Installation](#installation)
  - [Playbooks](#playbooks)
    - [rpi](#rpi)
      - [Pi-hole](#pi-hole)
    - [macOS \[WIP\]](#macos-wip)
  - [References](#references)

## Installation

```bash
git clone https://github.com/nirantak/infra-automation.git
cd infra-automation
python3 -m venv .venv
source .venv/bin/activate
pip install -U -r requirements.txt
ansible-galaxy collection install -r requirements.yml

# To set up pre-commit hooks, required for contributing code, run:
pre-commit install --install-hooks --overwrite

# On macOS, if you need to use the `-k` flag with ansible-playbook, run:
brew install nirantak/tap/sshpass
```

Update the following files to your liking:

- `inventory.ini` (replace IP address with your server's IP, or use `127.0.0.1` and add `connection=local` at the end if you're running it on the machine you're setting up).
- `group_vars/<group>.yml` to update the config for any host group from the inventory.

---

## Playbooks

### rpi

> _Raspberry Pi setup and config for all things Internet_

- Download [Raspberry Pi OS Lite 64-bit](https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit) and flash it on a Micro SD Card using [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
  - Configure the WiFi and SSH setting in Raspberry Pi Imager.
- Update the config file [group_vars/rpi.yml](group_vars/rpi.yml) as per your needs.
- Update the inventory file [inventory.ini](inventory.ini) with the correct IP and username.
- Once you are able to ssh into the rpi using your credentials, run the ansible playbook to set it up.

```bash
# To run the entire setup:
ansible-playbook playbooks/raspberry_pi.yml
# Tested on Raspberry Pi OS
# Use the `-k` flag in the command above if you have setup password based SSH.
# This is not needed once key-based ssh is setup.

# Or run select tasks or roles using tags:
ansible-playbook playbooks/raspberry_pi.yml -t ping
```

- To change Pi-hole web admin interface password, run `pihole -a -p`.
- To backup the Pi-hole config, run `pihole -a -t <backup-pihole.tar.gz>`.

#### Pi-hole

Installs the Pi-hole for network-wide ad-blocking and local DNS. Make sure to update your network router config to direct all DNS queries through your Raspberry Pi if you want to use Pi-hole effectively.

**Pi-hole**: Access the Pi-hole dahsboard using any of the following links and use the `pihole_password` you configured in your `config.yml` file.

- The rpi_hostname setup (eg: [pie.run](http://pie.run/admin))
- The default domain name for Pi-hole setup ([pi.hole](https://pi.hole/admin))
- The IP address of the server (eg: [192.168.1.40](https://192.168.1.40/admin))

![Pi-hole Dashboard](.github/images/pi-hole.png)

---

### macOS [WIP]

> _Mac dev env setup and configuration_

- Update the config file [group_vars/mac.yml](group_vars/mac.yml) as per your needs, to select what software you want to install or configure.

```bash
# Install xcode command line tools
xcode-select --install

# To run the entire setup:
ansible-playbook playbooks/mac_dev_setup.yml -k
# Using the `-k` flag you can enter you macOS password before the playbook runs

# Or run select tasks or roles using tags:
ansible-playbook playbooks/mac_dev_setup.yml -k -t ping
```

- This setup can be tested using [geerlingguy/macos-virtualbox-vm](https://github.com/geerlingguy/macos-virtualbox-vm)

---

## References

- [geerlingguy/internet-pi](https://github.com/geerlingguy/internet-pi)
- [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)
