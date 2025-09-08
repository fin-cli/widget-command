<?php

if ( ! class_exists( 'FP_CLI' ) ) {
	return;
}

$fpcli_widget_autoloader = __DIR__ . '/vendor/autoload.php';
if ( file_exists( $fpcli_widget_autoloader ) ) {
	require_once $fpcli_widget_autoloader;
}

FP_CLI::add_command( 'widget', 'Widget_Command' );
FP_CLI::add_command( 'sidebar', 'Sidebar_Command' );
