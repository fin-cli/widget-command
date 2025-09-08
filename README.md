fp-cli/widget-command
=====================

Adds, moves, and removes widgets; lists sidebars.

[![Testing](https://github.com/fp-cli/widget-command/actions/workflows/testing.yml/badge.svg)](https://github.com/fp-cli/widget-command/actions/workflows/testing.yml)

Quick links: [Using](#using) | [Installing](#installing) | [Contributing](#contributing) | [Support](#support)

## Using

This package implements the following commands:

### fp widget

Manages widgets, including adding and moving them within sidebars.

~~~
fp widget
~~~

A [widget](https://developer.finpress.org/themes/functionality/widgets/) adds content and features to a widget area (also called a [sidebar](https://developer.finpress.org/themes/functionality/sidebars/)).

**EXAMPLES**

    # List widgets on a given sidebar
    $ fp widget list sidebar-1
    +----------+------------+----------+----------------------+
    | name     | id         | position | options              |
    +----------+------------+----------+----------------------+
    | meta     | meta-6     | 1        | {"title":"Meta"}     |
    | calendar | calendar-2 | 2        | {"title":"Calendar"} |
    +----------+------------+----------+----------------------+

    # Add a calendar widget to the second position on the sidebar
    $ fp widget add calendar sidebar-1 2
    Success: Added widget to sidebar.

    # Update option(s) associated with a given widget
    $ fp widget update calendar-1 --title="Calendar"
    Success: Widget updated.

    # Delete one or more widgets entirely
    $ fp widget delete calendar-2 archive-1
    Success: 2 widgets removed from sidebar.



### fp widget add

Adds a widget to a sidebar.

~~~
fp widget add <name> <sidebar-id> [<position>] [--<field>=<value>]
~~~

Creates a new widget entry in the database, and associates it with the
sidebar.

**OPTIONS**

	<name>
		Widget name.

	<sidebar-id>
		ID for the corresponding sidebar.

	[<position>]
		Widget's current position within the sidebar. Defaults to last

	[--<field>=<value>]
		Widget option to add, with its new value

**EXAMPLES**

    # Add a new calendar widget to sidebar-1 with title "Calendar"
    $ fp widget add calendar sidebar-1 2 --title="Calendar"
    Success: Added widget to sidebar.



### fp widget deactivate

Deactivates one or more widgets from an active sidebar.

~~~
fp widget deactivate <widget-id>...
~~~

Moves widgets to Inactive Widgets.

**OPTIONS**

	<widget-id>...
		Unique ID for the widget(s)

**EXAMPLES**

    # Deactivate the recent-comments-2 widget.
    $ fp widget deactivate recent-comments-2
    Success: 1 widget deactivated.



### fp widget delete

Deletes one or more widgets from a sidebar.

~~~
fp widget delete <widget-id>...
~~~

**OPTIONS**

	<widget-id>...
		Unique ID for the widget(s)

**EXAMPLES**

    # Delete the recent-comments-2 widget from its sidebar.
    $ fp widget delete recent-comments-2
    Success: Deleted 1 of 1 widgets.



### fp widget list

Lists widgets associated with a sidebar.

~~~
fp widget list <sidebar-id> [--fields=<fields>] [--format=<format>]
~~~

**OPTIONS**

	<sidebar-id>
		ID for the corresponding sidebar.

	[--fields=<fields>]
		Limit the output to specific object fields.

	[--format=<format>]
		Render output in a particular format.
		---
		default: table
		options:
		  - table
		  - csv
		  - ids
		  - json
		  - count
		  - yaml
		---

**AVAILABLE FIELDS**

These fields will be displayed by default for each widget:

* name
* id
* position
* options

There are no optionally available fields.

**EXAMPLES**

    $ fp widget list sidebar-1 --fields=name,id --format=csv
    name,id
    meta,meta-5
    search,search-3



### fp widget move

Moves the position of a widget.

~~~
fp widget move <widget-id> [--position=<position>] [--sidebar-id=<sidebar-id>]
~~~

Changes the order of a widget in its existing sidebar, or moves it to a
new sidebar.

**OPTIONS**

	<widget-id>
		Unique ID for the widget

	[--position=<position>]
		Assign the widget to a new position.

	[--sidebar-id=<sidebar-id>]
		Assign the widget to a new sidebar

**EXAMPLES**

    # Change position of widget
    $ fp widget move recent-comments-2 --position=2
    Success: Widget moved.

    # Move widget to Inactive Widgets
    $ fp widget move recent-comments-2 --sidebar-id=fp_inactive_widgets
    Success: Widget moved.



### fp widget reset

Resets sidebar.

~~~
fp widget reset [<sidebar-id>...] [--all]
~~~

Removes all widgets from the sidebar and places them in Inactive Widgets.

**OPTIONS**

	[<sidebar-id>...]
		One or more sidebars to reset.

	[--all]
		If set, all sidebars will be reset.

**EXAMPLES**

    # Reset a sidebar
    $ fp widget reset sidebar-1
    Success: Sidebar 'sidebar-1' reset.

    # Reset multiple sidebars
    $ fp widget reset sidebar-1 sidebar-2
    Success: Sidebar 'sidebar-1' reset.
    Success: Sidebar 'sidebar-2' reset.

    # Reset all sidebars
    $ fp widget reset --all
    Success: Sidebar 'sidebar-1' reset.
    Success: Sidebar 'sidebar-2' reset.
    Success: Sidebar 'sidebar-3' reset.



### fp widget update

Updates options for an existing widget.

~~~
fp widget update <widget-id> [--<field>=<value>]
~~~

**OPTIONS**

	<widget-id>
		Unique ID for the widget

	[--<field>=<value>]
		Field to update, with its new value

**EXAMPLES**

    # Change calendar-1 widget title to "Our Calendar"
    $ fp widget update calendar-1 --title="Our Calendar"
    Success: Widget updated.



### fp sidebar

Lists registered sidebars.

~~~
fp sidebar
~~~

A [sidebar](https://developer.finpress.org/themes/functionality/sidebars/) is any widgetized area of your theme.

**EXAMPLES**

    # List sidebars
    $ fp sidebar list --fields=name,id --format=csv
    name,id
    "Widget Area",sidebar-1
    "Inactive Widgets",fp_inactive_widgets



### fp sidebar list

Lists registered sidebars.

~~~
fp sidebar list [--fields=<fields>] [--format=<format>]
~~~

**OPTIONS**

	[--fields=<fields>]
		Limit the output to specific object fields.

	[--format=<format>]
		Render output in a particular format.
		---
		default: table
		options:
		  - table
		  - csv
		  - json
		  - ids
		  - count
		  - yaml
		---

**AVAILABLE FIELDS**

These fields will be displayed by default for each sidebar:

* name
* id
* description

These fields are optionally available:

* class
* before_widget
* after_widget
* before_title
* after_title

**EXAMPLES**

    $ fp sidebar list --fields=name,id --format=csv
    name,id
    "Widget Area",sidebar-1
    "Inactive Widgets",fp_inactive_widgets

## Installing

This package is included with FP-CLI itself, no additional installation necessary.

To install the latest version of this package over what's included in FP-CLI, run:

    fp package install git@github.com:fp-cli/widget-command.git

## Contributing

We appreciate you taking the initiative to contribute to this project.

Contributing isn’t limited to just code. We encourage you to contribute in the way that best fits your abilities, by writing tutorials, giving a demo at your local meetup, helping other users with their support questions, or revising our documentation.

For a more thorough introduction, [check out FP-CLI's guide to contributing](https://make.finpress.org/cli/handbook/contributing/). This package follows those policy and guidelines.

### Reporting a bug

Think you’ve found a bug? We’d love for you to help us get it fixed.

Before you create a new issue, you should [search existing issues](https://github.com/fp-cli/widget-command/issues?q=label%3Abug%20) to see if there’s an existing resolution to it, or if it’s already been fixed in a newer version.

Once you’ve done a bit of searching and discovered there isn’t an open or fixed issue for your bug, please [create a new issue](https://github.com/fp-cli/widget-command/issues/new). Include as much detail as you can, and clear steps to reproduce if possible. For more guidance, [review our bug report documentation](https://make.finpress.org/cli/handbook/bug-reports/).

### Creating a pull request

Want to contribute a new feature? Please first [open a new issue](https://github.com/fp-cli/widget-command/issues/new) to discuss whether the feature is a good fit for the project.

Once you've decided to commit the time to seeing your pull request through, [please follow our guidelines for creating a pull request](https://make.finpress.org/cli/handbook/pull-requests/) to make sure it's a pleasant experience. See "[Setting up](https://make.finpress.org/cli/handbook/pull-requests/#setting-up)" for details specific to working on this package locally.

## Support

GitHub issues aren't for general support questions, but there are other venues you can try: https://fp-cli.org/#support


*This README.md is generated dynamically from the project's codebase using `fp scaffold package-readme` ([doc](https://github.com/fp-cli/scaffold-package-command#fp-scaffold-package-readme)). To suggest changes, please submit a pull request against the corresponding part of the codebase.*
