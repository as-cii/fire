Feature: Applications closing

  Scenario: User closes open applications
    Given a file named ".fire" with:
    """
    test: 'ruby process.rb'
    """
      And a file named "process.rb" with:
    """
    trap("INT") do
      File.write("closed", "")
      exit
    end

    gets
    """
     When I successfully run `fire`
      And I successfully run `fire --stop`
     Then a file named "closed" should exist
