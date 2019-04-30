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
[ ${LAUNCH_AFTER_BUILD} == "true" ] && kubectl create ns ${LAUNCH_NAMESPACE} && switchNS

for MDIR in `ls -d */`; do
	docker build -t ${REGISTRY_HOST}:${REGISTRY_PORT}/${MDIR%/}:latest ./${MDIR}
	docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/${MDIR%/}:latest

	[ ${LAUNCH_AFTER_BUILD} == "true" ] && kubectl apply -f ${MDIR}/deploy/
done

exit 0
