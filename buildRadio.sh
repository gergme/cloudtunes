#!/usr/bin/env bash

REGISTRY_HOST="localhost"
REGISTRY_PORT="5000"
K8S_CONTEXT="minikube"

command -v docker >/dev/null 2>&1 || { echo >&2 "I require docker but it's not installed.  Aborting."; exit 1; }
command -v kubectl >/dev/null 2>&1 || { echo >&2 "I require kubtctl but it's not installed.  Aborting."; exit 1; }
command -v kubectx >/dev/null 2>&1 || { echo >&2 "I require kubectx but it's not installed.  Aborting."; exit 1; }
command -v kubens >/dev/null 2>&1 || { echo >&2 "I require kubens but it's not installed.  Aborint."; exit 1; }

LAUNCH_NAMESPACE="radio"
LAUNCH_AFTER_BUILD="false"

function switchNS {
	kubectx ${K8S_CONTEXT}
	kubens ${LAUNCH_NAMESPACE}
}

# Create namespace
function createNS {
[ ${LAUNCH_AFTER_BUILD} == "true" ] && kubectl create ns ${LAUNCH_NAMESPACE} && switchNS
}

while test $# -gt 0; do
		case "$1" in
			-h|--help)
					version
					echo "options:"
					echo "-h, --help		Its what youre looking at!"
					echo "-b, --build		Build CloudTunes"
					echo "-l, --launch		Launch CloudTunes after build"
					echo "-d, --destroy		Destroy CloudTunes"
					echo "-v, --version		Show version"
					exit 0
					;;
			-b|--build)
					createNS
					switchNS
					for MDIR in `ls -d */`; do
						docker build -t ${REGISTRY_HOST}:${REGISTRY_PORT}/${MDIR%/}:latest ./${MDIR}
						docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/${MDIR%/}:latest
					done
					shift
					;;
			-l|--launch)
					switchNS
					for MDIR in `ls -d */`; do
						kubectl create -f ${MDIR}/deploy/
					done
					exit 0
					;;
			-d|--destroy)
					switchNS
					for MDIR in `ls -d */`; do
						kubectl delete -f ${MDIR}/deploy/
					done
					exit 0
					;;
			-v|--version)
					echo "0.0.1"
					exit 0
					;;
			*)
					break
					;;
					esac
done
echo ":)"
exit 0
