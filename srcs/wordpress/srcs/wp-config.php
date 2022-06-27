<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'WP_DB_USER' );

/** MySQL database password */
define( 'DB_PASSWORD', 'WP_DB_PASSWORD' );

/** MySQL hostname */
define( 'DB_HOST', 'DB_SERVER_ADDRESS' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ' @;|kT=,>c zr.oCx1ZrMo1A:1G}1D+JJ>H*o5)${:x%IG}))zk_!,#Qq@<*xR,d');
define('SECURE_AUTH_KEY',  'DVy;0`Ys jm&Zcr]YVH%M@PaoT9ra#5t8W)`m xbnoQ4+?yBfAh%+>!KRtQ^M$Uc');
define('LOGGED_IN_KEY',    'Q|)v|4JZM*=p#b%9*PL70-QKdzDVL>tFR7s7i2)l=)99su$Yc&>n;WQx&A>4.p`s');
define('NONCE_KEY',        'V.(]_j-c4OUycw+;g2U{mG2!t_C%_7?c7|?l,f-Vl/[+m+ WYE-Bu,<iVR9f<w5t');
define('AUTH_SALT',        '{T]:rwJUY;v4{*>29oj4l1:xd}G|P$r&ZZ+V91i&oNQ]B/K>S0fC5?c68l&L+R+J');
define('SECURE_AUTH_SALT', 'wZp|tH 0!x!Jx(p|,k-^zd81+AKsMnl_?tG0>-WYkmSo.H!_31i&(|1O##TyfX-<');
define('LOGGED_IN_SALT',   'YHyP}-j/CXTKkSBn-Z^!YX-G[lOR;NX@>4vgoZaS^f5BEbM1oidLkcjbJ@o+}*`E');
define('NONCE_SALT',       'gwhv1NE[K3#>mS=eb+$+6QIXD{($mLVKr~dN*%ENPRb+v-m8lA{]3&EbZMmH6vJP');

/**#@-*/

/**
 * WordPress Database Table prefix.
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
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
