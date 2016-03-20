Memcached Docker Image by NikoWoot.
	Based on "Base Docker Image by NikoWoot".

Included packages (in base image) : - wget
		   							- zip, unzip
Included packages : - memcached

Softwares is in default version of debian 8 repositories.

==========

CREATED and MAINTENED BY
Nicolas GAUTIER <ngautier@enroot.fr>

==========
	Fork me, if you like my repository.
==========

=> I have a problem with your image :
- You can send a mail for any questions.

=> I want check if memcached is ready :
- You can use a telnet connection 
For example : 

# Setting a key
telnet 127.0.0.1 11211
set greeting 1 0 23
Hello NikoWoot Docker !
# Show STORED in telnet console

# Getting a key
get greeting
# Show value in telnet console