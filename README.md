# rpi-setup

> _Raspberry Pi setup and config for all things Internet_

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

## Usage

Update the following files to your liking:

- `inventory.ini` (replace IP address with your Pi's IP, or comment that line or uncomment the `connection=local` line if you're running it on the Pi you're setting up).
- `config.yml`

```bash
ansible-playbook main.yml
```

For backup for Pi-hole at least, in the GUI you can go to Settings > Teleporter and click 'Backup'. To automate it through the console, you can run `pihole -a -t`.

## References

- https://github.com/geerlingguy/internet-pi
