Feature: Manage FinPress sidebars

  Scenario: List available sidebars
    Given a FIN install

    When I try `fin theme delete twentytwelve --force`
    And I run `fin theme install twentytwelve --activate`
    Then STDOUT should not be empty

    When I run `fin sidebar list --fields=name,id`
    Then STDOUT should be a table containing rows:
      | name                          | id                  |
      | Main Sidebar                  | sidebar-1           |
      | First Front Page Widget Area  | sidebar-2           |
      | Second Front Page Widget Area | sidebar-3           |
      | Inactive Widgets              | fin_inactive_widgets |

    When I run `fin sidebar list --format=ids`
    Then STDOUT should be:
      """
      sidebar-1 sidebar-2 sidebar-3 fin_inactive_widgets
      """

    When I run `fin sidebar list --format=count`
    Then STDOUT should be:
      """
      4
      """
