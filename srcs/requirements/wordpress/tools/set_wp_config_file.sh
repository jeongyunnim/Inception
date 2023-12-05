# !bin/sh

if [ ! -f "/var/www/html/wp-config.php" ]; then
cat << EOF > /var/www/html/wp-config.php
<?php
define( 'DB_NAME', '${MYSQL_DB}' );
define( 'DB_USER', '${MYSQL_USER}' );
define( 'DB_PASSWORD', '${MYSQL_PW}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
\$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
require_once ABSPATH . 'wp-settings.php';
?>
EOF
fi