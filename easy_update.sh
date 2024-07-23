#!/usr/bin/env bash

update() {
    sudo apt update
    sudo apt upgrade -y
}

check_kernel() {
    current_kernel=$(uname -r)
    latest_kernel=$(dpkg -l | awk '/linux-image-[0-9]/{print $2}' | sort -V | tail -n 1 | cut -d'-' -f3-)

    if [ "$current_kernel" != "$latest_kernel" ]; then
        echo "Kernel has been updated. Do you want to reboot? (y/n)"
        read response
        if [ $response == "y" ]; then
            echo "Rebooting"
            sudo reboot
        else
            echo "Done!"
        fi
    else
        echo "Kernel is up to date, no need to reboot."
    fi
}

main() {
    update
    if [ $? -eq 0 ]; then
        check_kernel
    else
        echo "There was a problem while updating your package manager."
    fi
}

main
