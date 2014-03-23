Feature: Applications closing

  Scenario: User closes open applications
    Given a file named ".engines" with:
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
     When I successfully run `styoe`
      And I successfully run `styoe --stop`
     Then a file named "closed" should exist
      And a file named ".engines.pids" should not exist
