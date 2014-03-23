require 'styoe/configuration_resolver'

describe Styoe::ConfigurationResolver do

  let(:pids)     { { application1: 1, application2: 2 } }
  let(:pid_file) { instance_double(File) }

  it 'resolves and parses a configuration file' do
    allow_file_to_exist_and_return("#{Styoe::DOT_FILE}", sample_configuration)

    expect(subject.processes).to eq(['hello', 'world'])
  end

  it 'searches configuration recursively in parent directories' do
    allow_file_to_exist_and_return("../../#{Styoe::DOT_FILE}", sample_configuration)

    expect(subject.processes).to eq(['hello', 'world'])
  end

  it 'stops searching configuration when root is reached' do
    subject = described_class.new(stop_at: '/')
    allow(File).to receive(:dirname).and_return('/')

    expect { subject.processes }.to raise_error(Styoe::ConfigurationNotFound)
  end

  it 'searches active processes and deletes related pidfile' do
    allow_file_to_exist_and_return("#{Styoe::PID_FILE}", sample_pids)
    allow(File).to receive(:delete)

    active_processes = subject.active_processes

    expect(active_processes).to eq([ 1, 2 ])
    expect(File).to have_received(:delete).with("#{Styoe::PID_FILE}")
  end

  it 'searches active processes recursively' do
    allow_file_to_exist_and_return("../../#{Styoe::PID_FILE}", sample_pids)
    allow(File).to receive(:delete)

    active_processes = subject.active_processes

    expect(active_processes).to eq([ 1, 2 ])
    expect(File).to have_received(:delete).with("../../#{Styoe::PID_FILE}")
  end

  it 'stops searching active processes when root is reached' do
    subject = described_class.new(stop_at: '/')
    allow(File).to receive(:dirname).and_return('/')

    expect { subject.active_processes }.to raise_error(Styoe::ConfigurationNotFound)
  end

  it "dumps active processes on the same path of #{Styoe::DOT_FILE}" do
    pid_file = double
    pids = { application1: 1, application2: 2 }
    allow(File).to receive(:exist?).and_return(false, false, true)
    allow(File).to receive(:open).with("../../#{Styoe::PID_FILE}", "w").and_return(pid_file)
    allow(YAML).to receive(:dump).with(pids).and_return(sample_pids)
    allow(pid_file).to receive(:write)
    allow(pid_file).to receive(:close)

    subject.dump_pids(pids)

    expect(pid_file).to have_received(:write).with(sample_pids)
    expect(pid_file).to have_received(:close)
  end

  def allow_file_to_exist_and_return(path, read_file)
    allow_file_to_exist(path)
    allow(File).to receive(:read).with(path).and_return(read_file)
  end

  def allow_file_to_exist(path)
    allow(File).to receive(:exist?).and_return(false)
    allow(File).to receive(:exist?).with(path).and_return(true)
  end

  def sample_configuration
    <<-config
    application1: hello
    application2: world
    config
  end

  def sample_pids
    <<-pids
    application1: 1
    application2: 2
    pids
  end
end
