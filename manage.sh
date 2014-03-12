#/bin/bash

IMAGE="viliusl/ubuntu-sshd-nginx"

BUILD_CMD="sudo docker build -rm=true -t=$IMAGE ."
RUN_CMD="sudo docker run -d -p 55522:22 -p 55580:80 $IMAGE"
SSH_CMD="ssh root@localhost -p 55522"

ID=`sudo docker ps | grep "$IMAGE" | head -n1 | cut -d " " -f1`

is_running() {
	[ "$ID" ]
}

case "$1" in
        build)
                echo "Building Docker image: '$IMAGE'"
                $BUILD_CMD
                ;;
        start)
                if is_running; then
                	echo "Image '$IMAGE' is already running under Id: '$ID'"
                	exit 1;
                fi
                echo "Starting Docker image: '$IMAGE'"
                $RUN_CMD
                echo "Docker image: '$IMAGE' started"
                ;;

        stop)
                if is_running; then
					echo "Stopping Docker image: '$IMAGE' with Id: '$ID'"
	                sudo docker stop "$ID"
					echo "Docker image: '$IMAGE' with Id: '$ID' stopped"

                else
                	echo "Image '$IMAGE' is not running"
                fi
                ;;

        status)
                if is_running; then
                	echo "Image '$IMAGE' is running under Id: '$ID'"
                else
                	echo "Image '$IMAGE' is not running"
                fi		
                ;;
        ssh)
                if is_running; then
                	echo "Attaching to running image '$IMAGE' with Id: '$ID'"
                	$SSH_CMD
                else
                	echo "Image '$IMAGE' is not running"
                fi		
                ;;

        *)
                echo "Usage: $0 {build|start|stop|status|ssh}"
                exit 1
                ;;
esac

exit 0