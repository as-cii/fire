Feature: Application launching

  Scenario: User writes configuration on current directory
    Given a file named ".fire" with:
    """
    app1: 'touch x'
    app2: 'touch y'
    """
     When I run `fire`
     Then the exit status should be 0
      And a file named "x" should exist
      And a file named "y" should exist

  Scenario: User writes configuration on parent directory
    Given a file named ".fire" with:
    """
    app1: 'touch x'
    app2: 'touch y'
    """
     And a directory named "sub/directory"
    When I cd to "sub/directory"
     And I run `fire`
    Then the exit status should be 0
     And a file named "x" should exist
     And a file named "y" should exist

  Scenario: User has no configuration
    When I run `fire`
    Then the exit status should be 1
     And the output should contain:
     """
     No configuration found. Are you sure you have created a .fire file?
     """
