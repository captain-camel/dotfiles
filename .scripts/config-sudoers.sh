#!/bin/sh

readonly TARGET='/etc/sudoers.d/pwfeedback'
echo 'Defaults pwfeedback' | sudo tee "$TARGET" >/dev/null
sudo chown root:wheel "$TARGET"
sudo chmod 440 "$TARGET"
