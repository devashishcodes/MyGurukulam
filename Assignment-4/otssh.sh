#!/bin/bash
DB="$HOME/.otssh/servers.db"
mkdir -p "$HOME/.otssh"
touch "$DB"
case "$1" in
-a)
    shift
    port="22"
    key=""
    while [ $# -gt 0 ]
    do
        case "$1" in
            -n)
                name="$2"
                shift 2
                ;;
            -h)
                host="$2"
                shift 2
                ;;
            -u)
                user="$2"
                shift 2
                ;;
            -p)
                port="$2"
                shift 2
                ;;
            -i)
                key=$(eval echo "$2")
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
    echo "$name|$host|$user|$port|$key" >> "$DB"
    echo "Connection added successfully."
    ;;
-u)
    shift
    port="22"
    key=""
    while [ $# -gt 0 ]
    do
        case "$1" in
            -n)
                name="$2"
                shift 2
                ;;
            -h)
                host="$2"
                shift 2
                ;;
            -u)
                user="$2"
                shift 2
                ;;
            -p)
                port="$2"
                shift 2
                ;;
            -i)
                key="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
if grep -q "^$name|" "$DB"; then
    tmpfile="$HOME/.otssh/temp.db"
    grep -v "^$name|" "$DB" > "$tmpfile"
    echo "$name|$host|$user|$port|$key" >> "$tmpfile"
    mv "$tmpfile" "$DB"
    echo "Connection updated successfully."
else
    echo "[ERROR]: Server '$name' not found."
fi
    ;;
ls)
    if [ "$2" = "-d" ]; then
        while IFS="|" read -r name host user port key
        do
            if [ -n "$key" ]; then
                echo "$name: ssh -i $key -p $port $user@$host"
            elif [ "$port" = "22" ]; then
                echo "$name: ssh $user@$host"
            else
                echo "$name: ssh -p $port $user@$host"
            fi
        done < "$DB"
    else
        cut -d'|' -f1 "$DB"
    fi
    ;;
rm)
    if [ -z "$2" ]; then
        echo "Usage: ./otssh rm <server_name>"
        exit 1
    fi
    if grep -q "^$2|" "$DB"; then
        tmpfile="$HOME/.otssh/temp.db"
        grep -v "^$2|" "$DB" > "$tmpfile"
        mv "$tmpfile" "$DB"
        echo "Server '$2' deleted successfully."
    else
        echo "[ERROR]: Server '$2' not found."
    fi
    ;;
*)
    server="$1"
    line=$(grep "^$server|" "$DB")
    if [ -z "$line" ]; then
        echo "[ERROR]: Server information is not available."
        exit 1
    fi
    IFS="|" read -r name host user port key <<< "$line"
    echo "Connecting to $name..."
    echo "Connecting to $name on $port port as $user via $key key"
    ;;
esac