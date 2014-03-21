require 'minitest/autorun'
require 'fire'

describe Fire::Launcher do
  let(:configuration_resolver) { Fire::ConfigurationResolver.new }
  let(:process_launcher)       { Minitest::Mock.new }
  let(:processes) { [ "app1", "app2", "app3" ] }

  subject { Fire::Launcher.new(configuration_resolver, process_launcher) }

  it "launches configuration processes" do
    stub_processes_launch

    configuration_resolver.stub(:processes, processes) do
      subject.start
    end

    process_launcher.verify
  end

  def stub_processes_launch
    processes.each do |process|
      process_launcher.expect(:launch, nil, [process])
    end
  end
end
