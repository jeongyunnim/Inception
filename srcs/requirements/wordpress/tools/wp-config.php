<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */

/** 환경변수로 해주는 것이 좋을 것 같다. 여차하면 그냥 쉘 스크립트로 처리하기 */
define( 'DB_NAME', '${WP_DB_NAME}' );

/** Database username */
define( 'DB_USER', '' );

/** Database password */
define( 'DB_PASSWORD', 'wordpress' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'aqm!Jf:-Q+2Tg]-jS M`)sA{A??#9p @Zq-]jUkI|Um<_R-|,.d@q8r ^fY=bQ||');
define('SECURE_AUTH_KEY',  '-1g~ D_ v<9U-1]j|:dSYfJaUa&$ljZ@/}2VAv/xDpohF|{!w*K:`d]eYRpwv6<(');
define('LOGGED_IN_KEY',    '%K;ynJgL(fer@>yYRx$~m9[nyq++I5{6.|-AbO<lPDc&DI}z:vgB-7@saE+GPSUR');
define('NONCE_KEY',        '&ch/d 55DOp<;+]^mo@KlQw<C&g9,+C5osCSGPZ-V:~>!gL>4.O9MyOZZx uZ^X~');
define('AUTH_SALT',        '+w9d3hEU(0n!8nUh))m+i>Vy.?y8!}@Z6y=:+-o?}*w*WLIDY0w-=Upb>5SHU+X^');
define('SECURE_AUTH_SALT', 'clGl(JC@*BxIx-r6c(`6LTC6knWT.p_~lJyO0i8YT)dP-l.s4F2I/+uCqF{gfHqK');
define('LOGGED_IN_SALT',   '(He_WyN{ZcVfDs-K=-+a<~5jb`&,oEFe37eDNY~`e;-93~FXv77d4)b0M|EJ_!DP');
define('NONCE_SALT',       '9<exX+^909G?M1MpmIM/+D?|l+o?rOQdlC-OZ`d(W%P(/efmo|fZlm*~]U^}J-C@');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';