# .shell_functions - Custom shell functions for convenience and system management

function upgrade_system_packages {
    /usr/bin/sudo nala clean
    /usr/bin/sudo nala upgrade -y \
        && /usr/bin/sudo nala autopurge -y \
        && /usr/bin/sudo nala clean
}

# a locked-down firefox instance running inside a sandbox
function safefox {
    /usr/bin/firejail --name=safe-firefox --apparmor --seccomp --private --private-dev --private-tmp --protocol=inet firefox --new-instance --no-remote --safe-mode --private-window $1
}

# update existing vagrant boxes
function update_vagrant_boxes {
    OLDIFS=$IFS
    export IFS=$'\n'

    # Find all boxes which have updates
    AVAILABLE_UPDATES=$(vagrant box outdated --global | grep outdated | tr -d "*'" | cut -d ' ' -f 2 2>/dev/null)

    if [[ ${#AVAILABLE_UPDATES[@]} -ne 0 ]]; then
        while read box; do
            echo "Found an update for ${box}"

            # Find all current versions
            boxinfo=$(vagrant box list | grep ${box})
            while read boxtype; do
                provider=$(echo ${boxtype} | awk -F\( '{print $2}' | awk -F\, '{print $1}')
                version=$(echo ${boxtype} | cut -d ',' -f 2 | tr -d ' )')

                # Add latest version
                vagrant box add --clean "${box}" --provider "${provider}"
                BOX_UPDATED="TRUE"
            done <<< ${boxinfo}
        done <<< ${AVAILABLE_UPDATES}
        echo "All boxes are now up to date! Pruning..."

        # Remove all old versions
        vagrant box prune -f
    else
        echo "All boxes are already up to date!"
    fi
    vagrant box outdated --global
    export IFS=$OLDIFS
}

# update existing docker images
function update_docker_images {
    docker images --format "{{.Repository}}:{{.Tag}}" | grep -v "<none>" | sort -u | xargs -L1 docker pull
    # cleanup images containing no tags; usually the ones which get updated
    if nonetags=$(docker images | grep "<none>"); then awk '{ print $3 }' <<< "$nonetags" | xargs -L1 docker rmi -f; fi
}

### BEGIN night light control ###
function night_light_enable {
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4700
}

function night_light_disable {
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
}

function night_light_low {
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4700
}

function night_light_medium {
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 4200
}

function night_light_high {
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 3700
}
### END night light control ###

# archive extraction
# usage: extract <file>
function extract {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    else
        for n in "$@"
        do
        if [ -f "$n" ] ; then
            case "${n%,}" in
              *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                            tar xvf "$n"       ;;
              *.lzma)      unlzma ./"$n"      ;;
              *.bz2)       bunzip2 ./"$n"     ;;
              *.cbr|*.rar)       unrar x -ad ./"$n" ;;
              *.gz)        gunzip ./"$n"      ;;
              *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
              *.z)         uncompress ./"$n"  ;;
              *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                            7z x ./"$n"        ;;
              *.xz)        unxz ./"$n"        ;;
              *.exe)       cabextract ./"$n"  ;;
              *.cpio)      cpio -id < ./"$n"  ;;
              *.cba|*.ace)      unace x ./"$n"      ;;
              *)
                            echo "ex: '$n' - unknown archive method"
                            return 1
                            ;;
            esac
        else
            echo "'$n' - file does not exist"
            return 1
        fi
        done
    fi
}
