#!/bin/bash

case "$1" in

    addTeam)
        groupadd "$2"
        ;;

    addUser)
        useradd -m -g "$3" "$2"
        mkdir -p /home/$2/team
        mkdir -p /home/$2/ninja
        chown -R "$2:$3" /home/$2
        chmod 751 /home/$2
        chmod 770 /home/$2/team
        usermod -aG ninja "$2"
        chgrp ninja /home/$2/ninja
        chmod 770 /home/$2/ninja
        ;;

    delUser)
        userdel -r "$2"
        ;;

    delTeam)
        groupdel "$2"
        ;;

    changePasswd)
        passwd "$2"
        ;;

    changeShell)
        usermod -s "$3" "$2"
        ;;

    ls)
        case "$2" in
            user)
                cut -d: -f1 /etc/passwd
                ;;

            team)
                cut -d: -f1 /etc/group
                ;;

            *)
                echo "Usage: ./usermanager.sh ls user|team"
                ;;
        esac
        ;;

    *)
        echo "Invalid command"
        ;;
esac