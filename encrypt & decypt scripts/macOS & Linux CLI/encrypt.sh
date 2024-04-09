#!/bin/bash

# Check if a file was passed as an argument
if [ -z "$1" ]; then
    echo "Usage: encrypt File"
    exit 1
fi

#scripts For Filza File Manager
#script modified for Linux and macOS
os=$(uname)
if [ "$os" == "Darwin" ]; then
    # macOS
    user_id=$(stat -f "%u" "$1")
    group_id=$(stat -f "%g" "$1")
elif [ "$os" == "Linux" ]; then
    # Linux
    user_id=$(stat -c "%u" "$1")
    group_id=$(stat -c "%g" "$1")
else
    echo "Unsupported operating system: $os"
    exit 1
fi
perms=$user_id:$group_id
echo "please set a passphrase"
read passphrase
#encrypt any file with scrypt
passphrase=$passphrase scrypt enc --passphrase env:passphrase "$1" "$1.enc"
chown -R $perms "$1.enc" &> /dev/null