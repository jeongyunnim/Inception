# !/bin/sh

mysql_install_db --user=mysql --datadir=/var/lib/mysql

if [ -d "/run/mysqld" ]; then
    echo "[i] mysqld already present, skipping createion"
    chown -R mysql:mysql /run/mysqld
else
    echo "[i] mysqld not found, creating..."
    mkdir -p /run/mysqld
    chown -R mysql:mysqld /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "[i] MySQL data directory not found, creating initial DBs"
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

tfile=`mktemp`
echo "tempfile is $tfile here is 21"

if [ ! -d "/var/lib/mysql/wordpress" ]; then
	echo "tempfile is $tfile here is 24"
    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User = '';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db = 'test';
DELETE FROM mysql.user WHERE User = 'root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON `${MYSQL_DATABASE}`.* TO '${MYSQL_USER}'@'%';
EOF
	echo "==temp file=="
	cat $tfile

    /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
	rm -f $tfile
fi
echo "end 42"

mysqld -u mysql