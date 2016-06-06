Automysqlbackup Docker Image by lumiru.
	Based on "Base Docker Image by lumiru".

Included packages (in base image):
* wget
* zip, unzip

Included packages:
* automysqlbackup

Softwares is in default version of debian 8 repositories.

__________

CREATED and MAINTENED BY
Frédéric TURPIN <contact@turp.in>

__________

## Usage

This docker image runs a mysqlbackup at start and stop.
Settings must be in `/srv/etc/automysqlbackup/automysqlbackup`.
An example is provided by `automysqlbackup.default` file.
