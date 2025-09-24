#!/bin/bash

windowsPath="${LOCALAPPDATA}\\nvim"
linuxPath="$HOME/.config/nvim"


linuxLink() {

    echo ${linuxPath}
    if [ -L "${linuxPath}" ]; then
        echo "Link Already Made: exiting"
        exit 1
    fi
    echo "Making Linux SysLink"
    echo "ln -s ./nvim ~/.config/nvim"
    ln -s ./nvim ~/.config/nvim
}


linkWindows(){
    echo "Link not supported, copy with "
    echo "cp ./nvim $windowsPath"
}

if [[ ! -d "./nvim" ]]; then
    echo "nvim directory not found"
    exit 1
fi


if [[ -n "$MSYSTEM" ]]; then
    linkWindows 
else
    linuxLink 
fi

