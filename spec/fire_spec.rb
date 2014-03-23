require 'fire'

describe Fire::Launcher do
  let(:configuration_resolver) { instance_double(Fire::ConfigurationResolver) }
  let(:process_launcher)       { instance_double(Fire::ProcessLauncher) }
  let(:processes)              { [ "app1", "app2", "app3" ] }
  let(:pids)                   { [ 1, 2, 3 ] }
  let(:running_processes)      { Hash[*processes.zip(pids).flatten] }

  subject { Fire::Launcher.new(configuration_resolver, process_launcher) }

  it "launches configuration processes and remembers open pids" do
    allow(configuration_resolver).to receive(:processes).and_return(processes)
    allow(configuration_resolver).to receive(:dump_pids)
    stub_processes_launch

    subject.start

    expect(configuration_resolver).to have_received(:dump_pids).with(running_processes)
  end

  it 'stops active processes' do
    allow(configuration_resolver).to receive(:active_processes).and_return(pids)
    allow(process_launcher).to receive(:stop)

    subject.stop

    expect_processes_stopped
  end

  private

  def stub_processes_launch
    processes.zip(pids).each do |process, pid|
      allow(process_launcher).to receive(:launch).with(process).and_return(pid)
    end
  end

  def expect_processes_stopped
    pids.each do |pid|
      expect(process_launcher).to have_received(:stop).with(pid)
    end
  end
end
