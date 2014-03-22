require 'fire'

describe Fire::Launcher do
  let(:configuration_resolver) { double }
  let(:process_launcher)       { double }
  let(:processes)              { [ "app1", "app2", "app3" ] }
  let(:pids)                   { [ 1, 2, 3 ] }

  subject { Fire::Launcher.new(configuration_resolver, process_launcher) }

  it "launches configuration processes" do
    configuration_resolver.stub(:processes).and_return(processes)
    process_launcher.stub(:launch)

    subject.start

    expect_processes_launched
  end

  it 'stops active processes' do
    configuration_resolver.stub(:active_processes).and_return(pids)
    process_launcher.stub(:stop)

    subject.stop

    expect_processes_stopped
  end

  private

  def expect_processes_launched
    processes.each do |process|
      expect(process_launcher).to have_received(:launch).with(process)
    end
  end

  def expect_processes_stopped
    pids.each do |pid|
      expect(process_launcher).to have_received(:stop).with(pid)
    end
  end
end
