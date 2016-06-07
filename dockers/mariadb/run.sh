#!/bin/bash

# =========================================
# Generate password (for production)
# =========================================
# $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)

# =========================================
# Configure MYSQLD
# =========================================
if [ ! -f ~/firstrun ]; then

	  # Check if volume is not mapped on this directory
	  if [ ! -f /usr/share/mysql/my-default.cnf ] ; then
	    echo "=> Write MySQLD default-configuration"

	  	sed -e 's/^datadir\t.*$/datadir = \/data/' -i /etc/mysql/my.cnf
	  	sed -e 's/^bind-address\t.*$/bind-address = 0.0.0.0/' -i /etc/mysql/my.cnf
	  	sed -e 's/^log_bin/#log_bin/' -i /etc/mysql/my.cnf
	  	sed -e 's/^log_bin_index/#log_bin_index/' -i /etc/mysql/my.cnf
	  	sed -e 's/^expire_logs_days/#expire_logs_days/' -i /etc/mysql/my.cnf
	  	sed -e 's/^max_binlog_size/#max_binlog_size/' -i /etc/mysql/my.cnf
	  	cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf
	  fi

	  echo "=> Install MySQLD database"
	  mysql_install_db > /dev/null 2>&1
 
 	  # Start MySQLD
      /usr/bin/mysqld_safe &
      while [ ! -S /var/run/mysqld/mysqld.sock ]; do sleep 1; done

 	  # Create new User with Admin rights
	  if [ -n "$SQL_USERNAME" ] && [ -n "$SQL_PASSWORD" ]; then

		if [ -z $SQL_USERHOST ]; then
			SQL_USERHOST='172.17.0.0/255.255.0.0'
		fi

      	 # Print in file and STDOUT
      	 echo "=> Create new admin $SQL_USERNAME:$SQL_PASSWORD"
   	     echo "$SQL_USERNAME:$SQL_PASSWORD" > /mysql.txt

   	     /usr/bin/mysql -uroot -e "CREATE USER '$SQL_USERNAME'@'$SQL_USERHOST' IDENTIFIED BY '$SQL_PASSWORD'"
   	     /usr/bin/mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO '$SQL_USERNAME'@'$SQL_USERHOST' WITH GRANT OPTION"
	  fi  

      # Create dabatase
      if [ -n "$SQL_DATABASE" ]; then
      	echo "=> Create Databse: \"$SQL_DATABASE\"..."
      	/usr/bin/mysql -uroot -e "CREATE DATABASE $SQL_DATABASE"
      fi

      # Stop MySQLD
      mysqladmin -uroot shutdown 
      while [ -S /var/run/mysqld/mysqld.sock ]; do sleep 1; done

      # Save firstrun
	  echo "true" > ~/firstrun
fi

# =========================================
# Launch MYSQLD
# =========================================
echo "=> Launch MySQLD"
/usr/sbin/mysqld
