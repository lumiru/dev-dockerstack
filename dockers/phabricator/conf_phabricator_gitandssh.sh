#!/bin/bash

# SSH DualServer Instance script is inspired by : https://github.com/denouche/bash-install-new-ssh-instance

# VCS : Version Control System
# VCS_USER : Used for all (GIT, SVN, HG) Communications by SSH tunnel
# DAEMON_USER : Launch all tasks for Phabricator (example : Create git repository)
DAEMON_USER="phabricator"
VCS_USER="vcs"

NEWPORT_SSHD=222
VCS_SSHD_AUTHORIZEDCOMMAND="/usr/bin/phabricator-ssh-hook.sh"
VCS_SSHD_AUTHORIZEDCOMMANDUSER="${VCS_USER}"
VCS_SSHD_ALLOWUSERS="${VCS_USER}"
VCS_SSHD_PORT=22
VCS_SSHD_SUFFIX="phabricator"

PHABRICATOR_PATH="/var/www/html/phabricator/"

function userExist() {
    user=$1
    grep -c '^${user}:' /etc/passwd
    mkdir -p /home/${user}
}

function configureVCSFromSSH() {
    echo "Create users"
    cp /etc/sudoers /etc/sudoers.old

    if [ `userExist ${DAEMON_USER}` -eq 0 ]; then
        echo "Create user ${DAEMON_USER} without password"
        useradd ${DAEMON_USER} -s /bin/bash
        passwd -d ${DAEMON_USER}
    fi

    if [ `userExist ${VCS_USER}` -eq 0 ]; then
        echo "Create user ${VCS_USER} without password"
        useradd ${VCS_USER} -s /bin/sh
        passwd -d ${VCS_USER}
        echo "Add ${VCS_USER} in /etc/sudoers"
        echo "${VCS_USER} ALL=(${DAEMON_USER}) SETENV: NOPASSWD: /usr/bin/git-upload-pack, /usr/bin/git-receive-pack, /usr/bin/hg, /usr/bin/svnserve" >> /etc/sudoers
    fi

    echo "Change password for ${VCS_USER}, ${DAEMON_USER}"
    cp /etc/shadow /etc/shadow.old
    sed -i "s/^${VCS_USER}:*:/${VCS_USER}:NP:/" /etc/shadow
    sed -i "s/^${DAEMON_USER}:*:/${DAEMON_USER}:NP:/" /etc/shadow

    echo "Comment 'requiretty' in /etc/sudoers"
    sed -i "s|^Defaults.*requiretty$|#$0|" /etc/sudoers

    echo "Restarting sudo service"
    service sudo restart

    echo "Change users and port for Phabricator"
    ./var/www/html/phabricator/bin/config set phd.user ${DAEMON_USER}
    ./var/www/html/phabricator/bin/config set diffusion.ssh-user ${VCS_USER}
    ./var/www/html/phabricator/bin/config set diffusion.ssh-port ${VCS_SSHD_PORT}

    echo "Copy phabricator file configuration for SSH hook"
    cp /var/www/html/phabricator/resources/sshd/phabricator-ssh-hook.sh ${VCS_SSHD_AUTHORIZEDCOMMAND}
    chown root ${VCS_SSHD_AUTHORIZEDCOMMAND}
    chmod 755 ${VCS_SSHD_AUTHORIZEDCOMMAND}
    sed -i "s/^VCSUSER=\".*\"/VCSUSER=\"${VCS_USER}\"/" ${VCS_SSHD_AUTHORIZEDCOMMAND}
    sed -i "s|^ROOT=\".*\"|ROOT=\"${PHABRICATOR_PATH}\"|" ${VCS_SSHD_AUTHORIZEDCOMMAND}

    echo "Clone SSHD to VCS-SSHD"
    cp /var/www/html/phabricator/resources/sshd/sshd_config.phabricator.example /etc/ssh/sshd_config-${VCS_SSHD_SUFFIX}
    sed -i "s/^Port .*/Port ${VCS_SSHD_PORT}/" /etc/ssh/sshd_config-${VCS_SSHD_SUFFIX}
    sed -i "s|^AuthorizedKeysCommand .*|AuthorizedKeysCommand ${VCS_SSHD_AUTHORIZEDCOMMAND}|" /etc/ssh/sshd_config-${VCS_SSHD_SUFFIX}
    sed -i "s/^AuthorizedKeysCommandUser .*/AuthorizedKeysCommandUser ${VCS_SSHD_AUTHORIZEDCOMMANDUSER}/" /etc/ssh/sshd_config-${VCS_SSHD_SUFFIX}
    sed -i "s/^AllowUsers .*/AllowUsers ${VCS_SSHD_ALLOWUSERS}/" /etc/ssh/sshd_config-${VCS_SSHD_SUFFIX}

    echo "Copy SSHD executable"
    ln -s /usr/sbin/sshd /usr/sbin/sshd-${VCS_SSHD_SUFFIX}

    echo "Copy launch executable"
    cp /etc/init.d/ssh /etc/init.d/ssh-${VCS_SSHD_SUFFIX}
    sed -r -i "s/(#\s+Provides:\s+sshd)/\1-${VCS_SSHD_SUFFIX}/g" /etc/init.d/ssh-${VCS_SSHD_SUFFIX}
    sed -r -i "s/(\/usr\/sbin\/sshd)/\1-${VCS_SSHD_SUFFIX}/g" /etc/init.d/ssh-${VCS_SSHD_SUFFIX}
    sed -r -i "s/(\/var\/run\/sshd)\.pid/\1-${VCS_SSHD_SUFFIX}.pid/g" /etc/init.d/ssh-${VCS_SSHD_SUFFIX}
    sed -r -i "s/(\/etc\/default\/ssh)/\1-${VCS_SSHD_SUFFIX}/g" /etc/init.d/ssh-${VCS_SSHD_SUFFIX}

    # Copy and configure default options
    cp /etc/default/ssh /etc/default/ssh-${VCS_SSHD_SUFFIX}
    sed -i "s/SSHD_OPTS=/SSHD_OPTS=\"-f \/etc\/ssh\/sshd_config-${VCS_SSHD_SUFFIX} -o PidFile=\/var\/run\/sshd-${VCS_SSHD_SUFFIX}.pid\"/g" \
    /etc/default/ssh-${VCS_SSHD_SUFFIX}

    # Start service at boot
    update-rc.d ssh-${VCS_SSHD_SUFFIX} defaults 99

    echo "Change port for SSHD"
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.old
    sed -i "s/^Port .*/Port ${NEWPORT_SSHD}/" /etc/ssh/sshd_config

    echo "Create repository directory"
    mkdir -p /var/repo
    chown -R ${DAEMON_USER} /var/repo
    chgrp -R ${DAEMON_USER} /var/repo

    echo "Restart SSHD with new configuration and Launch VCS-SSHD"
    service ssh restart
    service ssh-phabricator start
}

configureVCSFromSSH
