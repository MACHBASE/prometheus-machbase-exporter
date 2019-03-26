#!/bin/sh

set -e

# Connection arguments
MACHBASE_ADDRESS=localhost:5656
MACHBASE_USERNAME=SYS
MACHBASE_PASSWORD=MANAGER

PROMETHEUS_CLIENT_URL=https://files.pythonhosted.org/packages/4c/bd/b42db3ec90ffc6be805aad09c1cea4bb13a620d0cd4b21aaa44d13541d71/prometheus_client-0.6.0.tar.gz
PROMETHEUS_CLIENT_FILE=prometheus_client.tar.gz

if [ -z ${MACHBASE_HOME} ]; then
	echo "Environment variable MACHBASE_HOME is not set."
	exit 1
fi

if [ ! -e ${PROMETHEUS_CLIENT_FILE} ]; then
	echo "Downloading prometheus_client module..."
	curl -s -o ${PROMETHEUS_CLIENT_FILE} ${PROMETHEUS_CLIENT_URL}
	tar --strip-components=1 --wildcards -zxf ${PROMETHEUS_CLIENT_FILE} "*/prometheus_client/*"
fi

export PYTHONHOME=${MACHBASE_HOME}/webadmin/flask/Python
export PYTHONPATH=${PYTHONHOME}

exec ${PYTHONHOME}/bin/python machbase-exporter.py \
	-s ${MACHBASE_ADDRESS} \
	-u ${MACHBASE_USERNAME} \
	-P ${MACHBASE_PASSWORD}
