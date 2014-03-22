Feature: Applications closing

  Scenario: User closes open applications
    Given a file named ".fire" with:
    """
    man: 'man man'
    """
    When I run `fire`
    And I run `fire --stop`
    Then "man" process should not exist
