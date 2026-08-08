#!/bin/bash

DB="$HOME/.processmanager.db"
LOGDIR="$HOME/.processmanager"

mkdir -p "$LOGDIR"
touch "$DB"

get_info()
{
    grep "^$alias|" "$DB"
}

case "$1" in

-o)

    operation="$2"

    case "$operation" in

    register)

        while [ $# -gt 0 ]
        do
            case "$1" in
                -s)
                    script="$2"
                    shift 2
                    ;;
                -a)
                    alias="$2"
                    shift 2
                    ;;
                *)
                    shift
                    ;;
            esac
        done

        echo "$alias|$script|0" >> "$DB"

        echo "Service registered: $alias"
        ;;

    start)

        while [ $# -gt 0 ]
        do
            case "$1" in
                -a)
                    alias="$2"
                    shift 2
                    ;;
                *)
                    shift
                    ;;
            esac
        done

        info=$(get_info)

        if [ -z "$info" ]; then
            echo "Service not registered"
            exit 1
        fi

        script=$(echo "$info" | cut -d'|' -f2)

        nohup bash "$script" > "$LOGDIR/$alias.log" 2>&1 &

        pid=$!

        sed -i "s/^$alias|.*|.*/$alias|$script|$pid/" "$DB"

        echo "Service started"
        echo "PID: $pid"
        ;;

    status)

        while [ $# -gt 0 ]
        do
            case "$1" in
                -a)
                    alias="$2"
                    shift 2
                    ;;
                *)
                    shift
                    ;;
            esac
        done

        info=$(get_info)

        pid=$(echo "$info" | cut -d'|' -f3)

        if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null
        then
            echo "$alias is RUNNING (PID: $pid)"
        else
            echo "$alias is NOT RUNNING"
        fi
        ;;

    kill)

        while [ $# -gt 0 ]
        do
            case "$1" in
                -a)
                    alias="$2"
                    shift 2
                    ;;
                *)
                    shift
                    ;;
            esac
        done

        info=$(get_info)

        pid=$(echo "$info" | cut -d'|' -f3)

        if [ -n "$pid" ]; then
            kill "$pid"
            echo "$alias stopped"
        fi
        ;;

    priority)

        while [ $# -gt 0 ]
        do
            case "$1" in
                -a)
                    alias="$2"
                    shift 2
                    ;;
                -p)
                    priority="$2"
                    shift 2
                    ;;
                *)
                    shift
                    ;;
            esac
        done

        info=$(get_info)
        pid=$(echo "$info" | cut -d'|' -f3)

        case "$priority" in
            high)
                value=5
                ;;
            med)
                value=10
                ;;
            low)
                value=15
                ;;
            *)
                echo "Use high, med or low"
                exit 1
                ;;
        esac

        renice -n "$value" -p "$pid"
        ;;

    list)

        cut -d'|' -f1 "$DB"
        ;;

    top)

        while [ $# -gt 0 ]
        do
            case "$1" in
                -a)
                    alias="$2"
                    shift 2
                    ;;
                *)
                    shift
                    ;;
            esac
        done

        if [ -n "$alias" ]; then

            info=$(get_info)

            pid=$(echo "$info" | cut -d'|' -f3)
            script=$(echo "$info" | cut -d'|' -f2)

            ps -p "$pid" -o pid=,stat=,ni=

            echo "Alias: $alias"
            echo "Script: $script"

        else

            echo "Alias PID State Priority Script"

            while IFS='|' read -r alias script pid
            do
                if [ "$pid" != "0" ]; then
                    state=$(ps -p "$pid" -o stat= 2>/dev/null)
                    priority=$(ps -p "$pid" -o ni= 2>/dev/null)

                    echo "$alias $pid $state $priority $script"
                fi
            done < "$DB"

        fi
        ;;

    *)
        echo "Invalid operation"
        ;;

    esac
    ;;

*)
    echo "Usage:"
    echo "./ProcessManager.sh -o register -s <script> -a <alias>"
    echo "./ProcessManager.sh -o start -a <alias>"
    echo "./ProcessManager.sh -o status -a <alias>"
    echo "./ProcessManager.sh -o kill -a <alias>"
    echo "./ProcessManager.sh -o priority -p <high/med/low> -a <alias>"
    echo "./ProcessManager.sh -o list"
    echo "./ProcessManager.sh -o top [-a <alias>]"
    ;;

esac