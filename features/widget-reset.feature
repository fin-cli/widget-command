Feature: Reset FinPress sidebars

  Background:
    Given a FP install
    And I try `fp theme delete twentytwelve --force`
    And I run `fp theme install twentytwelve --activate`
    And I try `fp widget reset --all`
    And I try `fp widget delete fp_inactive_widgets $(fp widget list fp_inactive_widgets --format=ids)`

  Scenario: Reset sidebar
    Given I run `fp widget add text sidebar-1 --title="Text"`

    When I run `fp widget list sidebar-1 --format=count`
    # The count should be non-zero (= the sidebar contains widgets)
    Then STDOUT should match /^\s*[1-9][0-9]*\s*$/

    When I run `fp widget reset sidebar-1`
    And I run `fp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """

    When I try `fp widget reset`
    Then STDERR should be:
      """
      Error: Please specify one or more sidebars, or use --all.
      """

    When I try `fp widget reset sidebar-1`
    Then STDERR should be:
      """
      Warning: Sidebar 'sidebar-1' is already empty.
      """
    And STDOUT should be:
      """
      Success: Sidebar already reset.
      """
    And the return code should be 0

    When I try `fp widget reset non-existing-sidebar-id`
    Then STDERR should be:
      """
      Warning: Invalid sidebar: non-existing-sidebar-id
      Error: No sidebars reset.
      """
    And the return code should be 1

    When I run `fp widget add calendar sidebar-1 --title="Calendar"`
    Then STDOUT should not be empty

    When I run `fp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      1
      """

    When I run `fp widget add search sidebar-2 --title="Quick Search"`
    Then STDOUT should not be empty

    When I run `fp widget list sidebar-2 --format=count`
    # The count should be non-zero (= the sidebar contains widgets)
    Then STDOUT should match /^\s*[1-9][0-9]*\s*$/

    When I try `fp widget reset sidebar-1 sidebar-2 non-existing-sidebar-id`
    Then STDERR should be:
      """
      Warning: Invalid sidebar: non-existing-sidebar-id
      Error: Only reset 2 of 3 sidebars.
      """
    And the return code should be 1

    When I run `fp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """

    When I run `fp widget list sidebar-2 --format=count`
    Then STDOUT should be:
      """
      0
      """

  Scenario: Reset all sidebars
    When I run `fp widget add calendar sidebar-1 --title="Calendar"`
    Then STDOUT should not be empty
    When I run `fp widget add search sidebar-2 --title="Quick Search"`
    Then STDOUT should not be empty
    When I run `fp widget add text sidebar-3 --title="Text"`
    Then STDOUT should not be empty

    When I run `fp widget reset --all`
    Then STDOUT should be:
      """
      Sidebar 'sidebar-1' reset.
      Sidebar 'sidebar-2' reset.
      Sidebar 'sidebar-3' reset.
      Success: Reset 3 of 3 sidebars.
      """
    And the return code should be 0

    When I run `fp widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """
    When I run `fp widget list sidebar-2 --format=count`
    Then STDOUT should be:
      """
      0
      """
    When I run `fp widget list sidebar-3 --format=count`
    Then STDOUT should be:
      """
      0
      """
    When I run `fp widget list fp_inactive_widgets --format=ids`
    Then STDOUT should contain:
      """
      calendar-1
      """
    And STDOUT should contain:
      """
      search-1
      """
    And STDOUT should contain:
      """
      text-1
      """

  Scenario: Testing movement of widgets while reset
    When I run `fp widget add calendar sidebar-2 --title="Calendar"`
    Then STDOUT should not be empty

    When I run `fp widget add search sidebar-2 --title="Quick Search"`
    Then STDOUT should not be empty

    When I run `fp widget list sidebar-2 --format=ids`
    Then STDOUT should contain:
      """
      calendar-1 search-1
      """
    When I run `fp widget list fp_inactive_widgets --format=ids`
    Then STDOUT should be empty

    When I run `fp widget reset sidebar-2`
    And I run `fp widget list sidebar-2 --format=ids`
    Then STDOUT should be empty

    When I run `fp widget list fp_inactive_widgets --format=ids`
    And STDOUT should contain:
      """
      calendar-1 search-1
      """
