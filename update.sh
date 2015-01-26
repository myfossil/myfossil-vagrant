#!/usr/bin/env bash

set -e

function _pull {
    pushd $1 && git pull && popd;
}

function _clone {
    pushd $1 && git clone $2 $3 && popd;
}

function update {
    case "$1" in
        "wordpress")
            REPO_URL=git@github.com:myfossil/WordPress.git;
            PARENT=src;
            NAME=wp-core;
            ;;
        "buddypress")
            REPO_URL=git@github.com:myfossil/BuddyPress.git;
            PARENT=src/wp-content/plugins;
            NAME=buddypress;
            ;;
        "bbpress")
            REPO_URL=git@github.com:myfossil/bbPress.git;
            PARENT=src/wp-content/plugins;
            NAME=bbpress;
            ;;
        "wpmandrill")
            REPO_URL=git@github.com:myfossil/wpmandrill.git;
            PARENT=src/wp-content/plugins;
            NAME=wpmandrill;
            ;;
        "myfossil-resources")
            REPO_URL=git@github.com:myfossil/myfossil-resources.git;
            PARENT=src/wp-content/plugins;
            NAME=myfossil-resources;
            ;;
        "myfossil-specimen")
            REPO_URL=git@github.com:myfossil/myfossil-specimen.git;
            PARENT=src/wp-content/plugins;
            NAME=myfossil-specimen;
            ;;
        "myfossil-logging")
            REPO_URL=git@github.com:myfossil/myfossil-logging.git;
            PARENT=src/wp-content/plugins;
            NAME=myfossil-logging;
            ;;
        "myfossil-theme")
            REPO_URL=git@github.com:myfossil/myfossil-theme.git;
            PARENT=src/wp-content/themes;
            NAME=myfossil;
            ;;
    esac

    DIRECTORY=${PARENT}/${NAME};

    if [ ! -d "$PARENT" ]
    then
        mkdir -p $PARENT;
    fi

    if [ -d "$DIRECTORY" ]
    then
        _pull $DIRECTORY;
    else
        _clone $PARENT $REPO_URL $NAME;
    fi
}

for repo in `echo wordpress buddypress bbpress myfossil-resources \
        myfossil-specimen myfossil-logging myfossil-theme`
do
    update $repo;
done
