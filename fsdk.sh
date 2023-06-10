#!/bin/bash

# This shell script is an optional tool to simplify
# the installation and usage of fsdock with docker-compose.

# To run, make sure to add permissions to this file:
# chmod 755 fdk.sh

# USAGE EXAMPLE:
# Start services with default: ./fdk.sh up
# Stop containers: ./fdk.sh down
# Clean: ./fdk.sh clean

# prints colored text
print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m"
    elif [ "$2" == "success" ] ; then
        COLOR="92m"
    elif [ "$2" == "warning" ] ; then
        COLOR="93m"
    elif [ "$2" == "danger" ] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

display_options () {
    printf "Available options:\n";
    print_style "   up [services]" "success"; printf "\t Runs docker compose.\n"
    print_style "   down" "success"; printf "\t\t\t Stops containers.\n"
    print_style "   build" "success"; printf "\t\t\t Build image.\n"
    print_style "   logs" "success"; printf "\t\t\t Logs container.\n"
    print_style "   bash" "success"; printf "\t\t\t Opens bash on the workspace with user fsdock.\n"
    print_style "   clean" "danger"; printf "\t\t Removes all files from data、logs directory.\n"
}

if [[ $# -eq 0 ]] ; then
    print_style "Missing arguments.\n" "danger"
    display_options
    exit 1
fi

if [ "$1" == "up" ] ; then
    print_style "Initializing Docker Compose\n" "info"
    shift # removing first argument
    echo $1
    if [ "$1" == "--default" ] ; then
      shift
      defaultServices="nginx mysql rabbitmq redis"
      docker-compose up -d ${defaultServices} ${@}
    else
      docker-compose up -d ${@}
    fi

elif [ "$1" == "down" ]; then
    print_style "Stopping Docker Compose\n" "info"
    docker-compose stop

elif [ "$1" == "build" ]; then
    print_style "Building Docker Images\n" "info"
    shift
    docker-compose build ${@}

elif [ "$1" == "logs" ]; then
    print_style "Logs Docker Container\n" "info"
    shift
    docker-compose logs ${@}

elif [ "$1" == "bash" ]; then
    docker-compose exec --user=fsdock workspace bash

elif [ "$1" == "clean" ]; then
    print_style "Removing and cleaning up files from the data、logs directory.\n" "warning"
    rm -rf ./data/*
    rm -rf ./logs/*
else
    print_style "Invalid arguments.\n" "danger"
    display_options
    exit 1
fi
