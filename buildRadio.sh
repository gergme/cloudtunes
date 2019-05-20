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

function version() {
	printf "${0} v0.0.51\n"
}

function check_env() {
	[ -z ${DOCKER_HOST} ] && { printf "To use your local docker environment, use the --use-sysdocker flag!\nTo use the minikube docker environment, use 'eval \$(minikube docker-env)'\n"; exit 1; }
}

function switchNS {
	kubectx ${K8S_CONTEXT}
	kubens ${LAUNCH_NAMESPACE}
}

# Create namespace
function createNS {
kubectl create ns ${LAUNCH_NAMESPACE} && switchNS
}

while test $# -gt 0; do
		case "$1" in
			-h|--help)
					version
					echo "options:"
					echo "-h, --help		Its what youre looking at!"
					echo "-b, --build		(Re)build CloudTunes docker images"
					echo "-B, --browser		Launch CloudTunes service in browser"
					echo "-l, --launch		Launch CloudTunes"
					echo "-d, --destroy		Destroy CloudTunes"
					echo "-F, --full		Destroy, rebuild, then relaunch CloudTunes"
					echo "--use-sysdocker		Bypass enviornment checking"
					echo "-v, --version		Show version"
					exit 0
					;;
			--use-sysdocker)
					ENV_SKIP=1
					shift
					;;
			-b|--build)
					[[ ${ENV_SKIP} == "1" ]] || check_env
					createNS
					switchNS
					for MDIR in `ls -d */`; do
						docker build -t ${REGISTRY_HOST}:${REGISTRY_PORT}/${MDIR%/}:latest ./${MDIR}
						docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/${MDIR%/}:latest
					done
					shift
					;;
			-B|--browser)
					minikube service -n radio radio-fe-app
					exit 0
					;;
			-l|--launch)
					[[ $ENV_SKIP = "1" ]] || check_env
					switchNS
					for MDIR in `ls -d */`; do
						kubectl create -f ${MDIR}/deploy/
					done
					exit 0
					;;
			-d|--destroy)
					[[ $ENV_SKIP = "1" ]] || check_env
					switchNS
					for MDIR in `ls -d */`; do
						kubectl delete -f ${MDIR}/deploy/
					done
					exit 0
					;;
			-F|--full)
					[[ $ENV_SKIP = "1" ]] || check_env
					switchNS
					for MDIR in `ls -d */`; do
                                                kubectl delete -f ${MDIR}/deploy
                                        	docker build -t ${REGISTRY_HOST}:${REGISTRY_PORT}/${MDIR%/}:latest ./${MDIR}
                                        	docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/${MDIR%/}:latest
                                        	kubectl create -f ${MDIR}/deploy/
                                        done
                                        exit 0
                                        ;;
			-v|--version)
					version
					exit 0
					;;
			*)
					break
					;;
					esac
done
echo ":)"
exit 0
