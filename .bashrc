function opencode(){
  IMAGE="opencode"
  SUPERVISOR=false
  GIT_MASTER=false
  FEATURE_NAME=""
  REPO_MOUNT="-v $(pwd):/app"
  NAME=""

  while [[ $# -gt 0 ]]; do
    case $1 in
      -i|--image)
        IMAGE="$2"
        shift # past argument
        shift # past value
        ;;
      -s|--supervisor)
        SUPERVISOR=true
        shift # past argument
        ;;
      -m|--git-master)
        GIT_MASTER=true
        shift # past argument
        ;;
      -f|--feature)
        FEATURE_NAME="$2"
        NAME="--name oc_$2"
        shift # past argument
        shift # past value
        ;;
      -*|--*)
        echo "function opencode: Unknown option $1"
        return 1
        ;;
      *)
        ARGS+=("$1") # save positional arg
        shift # past argument
        ;;
    esac
  done

  # Determine git mount mode (skip if feature mode)
  if [ -n "$FEATURE_NAME" ]; then
    GIT_MOUNT=""  # No git mount - copied in Dockerfile
    REPO_MOUNT="" # No repo mount - copied in Dockerfile
  else
    if [ "$GIT_MASTER" = true ]; then
      GIT_MOUNT="-v $(pwd)/.git:/app/.git"
    else
      GIT_MOUNT="-v $(pwd)/.git:/app/.git:ro"
    fi
  fi

  # Determine docker socket mount
  DOCKER_SOCKET_MOUNT=""
  if [ "$SUPERVISOR" = true ]; then
    DOCKER_SOCKET_MOUNT="-v /var/run/docker.sock:/var/run/docker.sock"
  fi

  (set -x
    docker run \
    -ti \
    --rm \
    $NAME \
    $DOCKER_SOCKET_MOUNT \
    $REPO_MOUNT \
    $GIT_MOUNT \
    "$IMAGE"
  )
  return 0
}