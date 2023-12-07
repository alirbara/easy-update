#!/usr/bin/env bash

update() {
    apt update
    apt upgrade -y
}

check_kernel() {
    current_kernel=$(uname -r)
    latest_kernel=$(dpkg -l | awk '/linux-image-[0-9]/{print $2}' | sort -V | tail -n 1 | cut -d'-' -f3-)

    if [ "$current_kernel" != "$latest_kernel" ]; then
        echo "Kernel has been updated. Now, rebooting... 🔄"
        reboot
    else
        echo "Kernel is up to date, so no need to reboot. 😀"
    fi
}

main() {
    update
    if [ $? -eq 0 ]; then
        check_kernel
    else
        echo "There was a problem while updating your package manager. 😢"
    fi
}

main