#!/bin/bash

# =========================================
# Install software dependancies
# =========================================

DEBIAN_FRONTEND=noninteractive apt-get update && \
							   apt-get install -y cron curl openssh-server

# =========================================
# Install software (Gitlab)
# =========================================

curl $GITLAB_PACKAGES_URL | bash

DEBIAN_FRONTEND=noninteractive apt-get install -y gitlab-ce && \
                                                           apt-get clean && \
                                                           rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# From https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/docker/assets/setup

mkdir -p /opt/gitlab/sv/sshd/supervise /opt/gitlab/sv/sshd/log/supervise
mkfifo /opt/gitlab/sv/sshd/supervise/ok /opt/gitlab/sv/sshd/log/supervise/ok
printf '#!/bin/sh\nexec 2>&1\numask 077\nexec /usr/sbin/sshd -D -f /assets/sshd_config -e' > /opt/gitlab/sv/sshd/run
printf '#!/bin/sh\nexec svlogd -tt /var/log/gitlab/sshd' > /opt/gitlab/sv/sshd/log/run
chmod a+x /opt/gitlab/sv/sshd/run /opt/gitlab/sv/sshd/log/run
mkdir -p /var/run/sshd

rm -f /etc/gitlab/gitlab.rb
sed -i 's,external_url,# external_url,' /opt/gitlab/etc/gitlab.rb.template
cp /opt/gitlab/etc/gitlab.rb.template /etc/gitlab/gitlab.rb
chmod 0600 /etc/gitlab/gitlab.rb

# Create groups
groupadd -g 998 git
groupadd -g 999 gitlab-www
groupadd -g 997 gitlab-redis
groupadd -g 996 gitlab-psql
# groupadd -g 995 gitlab-ci
groupadd -g 994 mattermost

# Create accounts
useradd -m -u 998 -g git -m -s /bin/sh -d /var/opt/gitlab git
useradd -m -u 999 -g gitlab-www -m -s /bin/false -d /var/opt/gitlab/nginx gitlab-www
useradd -m -u 997 -g gitlab-redis -m -s /bin/nologin -d /var/opt/gitlab/redis gitlab-redis
useradd -m -u 996 -g gitlab-psql -m -s /bin/sh -d /var/opt/gitlab/postgresql gitlab-psql
# useradd -m -u 995 -g gitlab-ci -m -s /bin/sh -d /var/opt/gitlab/gitlab-ci gitlab-ci
useradd -m -u 994 -g mattermost -m -s /bin/sh -d /var/opt/gitlab/mattermost mattermost
