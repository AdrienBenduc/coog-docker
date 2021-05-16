#!/bin/bash
export BASE_PATH=`realpath "$(dirname $0)/.."`
. "${BASE_PATH}/helpers/colors.sh"
. "${BASE_PATH}/services.env"

FILES="docker-compose.yml"
for service in ${SERVICES[@]}
do
    service_file="compose/${service}.yml"
    if [ -f "$service_file" ]
    then
        check "${service} ajouté"
        FILES="${FILES}:${service_file}"
    else
        fail "${service} n'existe pas"
    fi
done

sed -i -E "s|^(COMPOSE_FILE=).*?$|\1$FILES|" "${BASE_PATH}/.env"
