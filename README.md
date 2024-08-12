# Infra Automation

> _Ansible playbooks to setup dev environments and home servers_

- [Infra Automation](#infra-automation)
  - [Installation](#installation)
  - [Playbooks](#playbooks)
    - [rpi](#rpi)
      - [Tailscale](#tailscale)
        - [Next Steps for Tailscale](#next-steps-for-tailscale)
      - [Pi-hole](#pi-hole)
        - [Next Steps for Pi-hole](#next-steps-for-pi-hole)
      - [Home Assistant](#home-assistant)
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
- `roles/raspberry_pi/files/sample.env` for any secrets to be passed to docker-compose.

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

- **NOTE**: some setup requires manual steps, you can view those by running the `manual` ansible tag.

```bash
# List all manual steps required:
ansible-playbook playbooks/raspberry_pi.yml -t manual
```

#### Tailscale

> _[tailscale.com](https://tailscale.com)_

- Tailscale can create a private network across all devices you have installed it on, allowing you to access your home server or Pi-hole DNS from anywhere even when away from your local home network.
- It creates a peer to peer VPN network using WireGuard.
- Create a tailscale account and then follow these steps:

```bash
# Run tasks for tailscale setup:
ansible-playbook playbooks/raspberry_pi.yml -t tailscale

# Tailscale requires manual login via the browser, so the above command may not set everything up.
# Run the following command and then login via the link displayed:
sudo tailscale up --qr

# Once login is complete, run ansible with this tag to update configuration that requires tailscale:
ansible-playbook playbooks/raspberry_pi.yml -t tailscale_configure
```

##### Next Steps for Tailscale

- If you want to use Pi-hole DNS across your Tailnet, go to [Tailscale's DNS settings](https://login.tailscale.com/admin/dns) and set these configs:
  - Set `Global nameservers` to the Tailscale IPv4 address of your Pi-hole server (get it by running `tailscale status`).
  - Enable `Override local DNS`.

#### Pi-hole

> _[pi-hole.net](https://pi-hole.net)_

Installs the Pi-hole for network-wide ad-blocking and local DNS. Make sure to update your network router config to direct all DNS queries through your Raspberry Pi if you want to use Pi-hole effectively.

**Pi-hole**: Access the Pi-hole dahsboard using any of the following links and use the `pihole_password` you configured in your `rpi.yml` file.

- The pihole_domain setup (eg: [dns.pie.run](http://dns.pie.run/admin))
- The IP/hostname address of the server with the configured pihole_port (eg: [pi.hole:8080](https://pi.hole:8080/admin))

![Pi-hole Dashboard](.github/images/pi-hole.png)

##### Next Steps for Pi-hole

- Set the IP address of the Pi-hole as the DNS server in your WiFi router or device's network settings.
- Also follow the [steps mentioned above](#next-steps-for-tailscale) to set Pi-hole as the DNS server for your Tailnet, so that ads are blocked when you are away from your home network.
  - This way, when you are connected to your WiFi, the configured DNS server will ensure that Pi-hole is being used even when you are not connected to Tailscale.
  - And when you connect to Tailscale either in the same WiFi network or away, it will override the DNS server setting, and you will always be connected to Pi-hole.

#### Home Assistant

> _[home-assistant.io](https://www.home-assistant.io)_

---

## References

- [geerlingguy/internet-pi](https://github.com/geerlingguy/internet-pi)
