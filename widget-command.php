<?php

if ( ! class_exists( 'FIN_CLI' ) ) {
	return;
}

$fincli_widget_autoloader = __DIR__ . '/vendor/autoload.php';
if ( file_exists( $fincli_widget_autoloader ) ) {
	require_once $fincli_widget_autoloader;
}

FIN_CLI::add_command( 'widget', 'Widget_Command' );
FIN_CLI::add_command( 'sidebar', 'Sidebar_Command' );
