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

#if rsync dry run don't do anything further
if [ ! -z "$DRY_RUN" ]; then
    echo "dry run - finish now"
    exit 0
fi

# special treatment for .gitignore
# exit if git.ignore file not in copy set
[ $(grep -q git.ignore ./rsync-items.txt) ] && exit 0

if [ -f "$DEST/.gitignore" ]; then
    # if different to target .gitignore then rename over
    if  ! cmp -s "$DEST/git.ignore" "$DEST/.gitignore" ;then
        mv "$DEST/git.ignore" "$DEST/.gitignore"
    fi
else
    mv "$DEST/git.ignore" "$DEST/.gitignore"
fi

[ -f "$DEST/git.ignore" ] && rm "$DEST/git.ignore"
