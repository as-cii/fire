require 'styoe/configuration_resolver'

describe Styoe::ConfigurationResolver do

  let(:dot_filename)     { '.engines' }
  let(:pid_filename)     { '.engines.pids' }
  let(:dot_file_manager) { instance_double(Styoe::DotFileManager) }

  subject { described_class.new(dot_filename, pid_filename, dot_file_manager) }

  it 'parses found configuration file' do
    stub_found_dotfile(dot_filename, sample_configuration)

    expect(subject.processes).to eq(['hello', 'world'])
  end

  it 'searches active processes and deletes related pidfile' do
    stub_found_dotfile(pid_filename, sample_pids)
    allow(File).to receive(:delete)

    active_processes = subject.active_processes

    expect(active_processes).to eq([ 1, 2 ])
    expect(File).to have_received(:delete).with(pid_filename)
  end

  it 'dumps active processes on the same path of dotfile' do
    allow(dot_file_manager).to receive(:save_near)
    subject.dump_pids(application1: 1, application2: 2)
    expect(dot_file_manager).to have_received(:save_near)
                                .with(dot_filename,
                                      new_name: pid_filename,
                                      contents: sample_pids)
  end

def sample_configuration
  <<-pids
---
:application1: hello
:application2: world
  pids
end

  def sample_pids
    <<-pids
---
:application1: 1
:application2: 2
    pids
  end

  def stub_found_dotfile(path, contents)
    configuration = Styoe::DotFile.new(path, contents)
    allow(dot_file_manager).to receive(:find_recursively).with(path).and_return(configuration)
  end

end
