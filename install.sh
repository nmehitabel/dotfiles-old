#!/bin/bash
# sync config files specified in rsync-items.txt to target directory
# default to home directory.

usage() {
    echo "Usage: $0 [ -c ] dest:~, -c for dry run, dest defaults to home directory" 1>&2 && exit 1
}

DRY_RUN=""
while getopts ':d' opt; do
  case ${opt} in
    d ) 
      echo "Dry Run selected"
      DRY_RUN="--dry-run"
      ;;
    \?) usage
      ;;
  esac
done

shift "$(($OPTIND -1))"

: ${HOME=~}
: ${DEST=${1:-$HOME}}

echo "sync to ${DEST:-''}"

$(which rsync) ${DRY_RUN}  -avrc --files-from=./rsync-items.txt ./ "$DEST"
