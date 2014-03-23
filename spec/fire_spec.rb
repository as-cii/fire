require 'fire'

describe Fire::Launcher do
  let(:configuration_resolver) { double }
  let(:process_launcher)       { double }
  let(:processes)              { [ "app1", "app2", "app3" ] }

  subject { Fire::Launcher.new(configuration_resolver, process_launcher) }

  it "launches configuration processes" do
    configuration_resolver.stub(:processes).and_return(processes)
    process_launcher.stub(:launch)

    subject.start

    expect_processes_launched
  end

  private

  def expect_processes_launched
    processes.each do |process|
      expect(process_launcher).to have_received(:launch).with(process)
    end
  end
end
