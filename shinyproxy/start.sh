#!/bin/bash
#-------------------------------------------------------------------------------
#
# startup.sh - perform variable replacement on our config file based on environment
#              variables, then spin up shinyproxy.
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
Main () {
    set -e
    if [[ ! -f "${SHINYPROXY_DOCKER_CONFIG_FILE}" ]]
    then
        BuildApplicationYmlFile "${SHINYPROXY_DOCKER_CONFIG_FILE_TEMPLATE}" > "${SHINYPROXY_DOCKER_CONFIG_FILE}"
    fi
    java -jar "${SHINYPROXY_INSTALL_DIR}"shinyproxy.jar
}

#-------------------------------------------------------------------------------
# replace all bash variables found in a file while preserving newlines and
# leading whitespace
#-------------------------------------------------------------------------------
BuildApplicationYmlFile () {
    while IFS='' read -r line || [[ -n $line ]]
    do
        whtspc=$(echo "$line" | sed -e "s/\S.*//" -)
        echo -n "$whtspc"
        eval echo $line
    done < $1
}

# kick everything off with Main
Main
