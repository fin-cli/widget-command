<?php

use FP_CLI\Utils;
use FP_CLI\Formatter;

/**
 * Lists registered sidebars.
 *
 * A [sidebar](https://developer.finpress.org/themes/functionality/sidebars/) is any widgetized area of your theme.
 *
 * ## EXAMPLES
 *
 *     # List sidebars
 *     $ fp sidebar list --fields=name,id --format=csv
 *     name,id
 *     "Widget Area",sidebar-1
 *     "Inactive Widgets",fp_inactive_widgets
 */
class Sidebar_Command extends FP_CLI_Command {

	private $fields = [
		'name',
		'id',
		'description',
	];

	/**
	 * Lists registered sidebars.
	 *
	 * ## OPTIONS
	 *
	 * [--fields=<fields>]
	 * : Limit the output to specific object fields.
	 *
	 * [--format=<format>]
	 * : Render output in a particular format.
	 * ---
	 * default: table
	 * options:
	 *   - table
	 *   - csv
	 *   - json
	 *   - ids
	 *   - count
	 *   - yaml
	 * ---
	 *
	 * ## AVAILABLE FIELDS
	 *
	 * These fields will be displayed by default for each sidebar:
	 *
	 * * name
	 * * id
	 * * description
	 *
	 * These fields are optionally available:
	 *
	 * * class
	 * * before_widget
	 * * after_widget
	 * * before_title
	 * * after_title
	 *
	 * ## EXAMPLES
	 *
	 *     $ fp sidebar list --fields=name,id --format=csv
	 *     name,id
	 *     "Widget Area",sidebar-1
	 *     "Inactive Widgets",fp_inactive_widgets
	 *
	 * @subcommand list
	 */
	public function list_( $args, $assoc_args ) {
		global $fp_registered_sidebars;

		Utils\fp_register_unused_sidebar();

		if ( ! empty( $assoc_args['format'] ) && 'ids' === $assoc_args['format'] ) {
			$sidebars = fp_list_pluck( $fp_registered_sidebars, 'id' );
		} else {
			$sidebars = $fp_registered_sidebars;
		}

		$formatter = new Formatter( $assoc_args, $this->fields );
		$formatter->display_items( $sidebars );
	}
}
