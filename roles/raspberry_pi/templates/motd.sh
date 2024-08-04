#!/bin/bash
export TERM=xterm-256color
fastfetch --thread --logo raspbian -c /home/{{ ansible_user }}/.config/fastfetch/config.jsonc --pipe false
