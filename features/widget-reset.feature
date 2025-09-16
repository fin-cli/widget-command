Feature: Reset FinPress sidebars

  Background:
    Given a FIN install
    And I try `fin theme delete twentytwelve --force`
    And I run `fin theme install twentytwelve --activate`
    And I try `fin widget reset --all`
    And I try `fin widget delete fin_inactive_widgets $(fin widget list fin_inactive_widgets --format=ids)`

  Scenario: Reset sidebar
    Given I run `fin widget add text sidebar-1 --title="Text"`

    When I run `fin widget list sidebar-1 --format=count`
    # The count should be non-zero (= the sidebar contains widgets)
    Then STDOUT should match /^\s*[1-9][0-9]*\s*$/

    When I run `fin widget reset sidebar-1`
    And I run `fin widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """

    When I try `fin widget reset`
    Then STDERR should be:
      """
      Error: Please specify one or more sidebars, or use --all.
      """

    When I try `fin widget reset sidebar-1`
    Then STDERR should be:
      """
      Warning: Sidebar 'sidebar-1' is already empty.
      """
    And STDOUT should be:
      """
      Success: Sidebar already reset.
      """
    And the return code should be 0

    When I try `fin widget reset non-existing-sidebar-id`
    Then STDERR should be:
      """
      Warning: Invalid sidebar: non-existing-sidebar-id
      Error: No sidebars reset.
      """
    And the return code should be 1

    When I run `fin widget add calendar sidebar-1 --title="Calendar"`
    Then STDOUT should not be empty

    When I run `fin widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      1
      """

    When I run `fin widget add search sidebar-2 --title="Quick Search"`
    Then STDOUT should not be empty

    When I run `fin widget list sidebar-2 --format=count`
    # The count should be non-zero (= the sidebar contains widgets)
    Then STDOUT should match /^\s*[1-9][0-9]*\s*$/

    When I try `fin widget reset sidebar-1 sidebar-2 non-existing-sidebar-id`
    Then STDERR should be:
      """
      Warning: Invalid sidebar: non-existing-sidebar-id
      Error: Only reset 2 of 3 sidebars.
      """
    And the return code should be 1

    When I run `fin widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """

    When I run `fin widget list sidebar-2 --format=count`
    Then STDOUT should be:
      """
      0
      """

  Scenario: Reset all sidebars
    When I run `fin widget add calendar sidebar-1 --title="Calendar"`
    Then STDOUT should not be empty
    When I run `fin widget add search sidebar-2 --title="Quick Search"`
    Then STDOUT should not be empty
    When I run `fin widget add text sidebar-3 --title="Text"`
    Then STDOUT should not be empty

    When I run `fin widget reset --all`
    Then STDOUT should be:
      """
      Sidebar 'sidebar-1' reset.
      Sidebar 'sidebar-2' reset.
      Sidebar 'sidebar-3' reset.
      Success: Reset 3 of 3 sidebars.
      """
    And the return code should be 0

    When I run `fin widget list sidebar-1 --format=count`
    Then STDOUT should be:
      """
      0
      """
    When I run `fin widget list sidebar-2 --format=count`
    Then STDOUT should be:
      """
      0
      """
    When I run `fin widget list sidebar-3 --format=count`
    Then STDOUT should be:
      """
      0
      """
    When I run `fin widget list fin_inactive_widgets --format=ids`
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
    When I run `fin widget add calendar sidebar-2 --title="Calendar"`
    Then STDOUT should not be empty

    When I run `fin widget add search sidebar-2 --title="Quick Search"`
    Then STDOUT should not be empty

    When I run `fin widget list sidebar-2 --format=ids`
    Then STDOUT should contain:
      """
      calendar-1 search-1
      """
    When I run `fin widget list fin_inactive_widgets --format=ids`
    Then STDOUT should be empty

    When I run `fin widget reset sidebar-2`
    And I run `fin widget list sidebar-2 --format=ids`
    Then STDOUT should be empty

    When I run `fin widget list fin_inactive_widgets --format=ids`
    And STDOUT should contain:
      """
      calendar-1 search-1
      """
