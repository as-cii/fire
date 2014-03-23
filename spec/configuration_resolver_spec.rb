require 'fire/configuration_resolver'

describe Fire::ConfigurationResolver do

  it 'resolves and parses a configuration file' do
    File.stub(:exist?).and_return(true)
    File.stub(:read).and_return(sample_configuration)

    expect(subject.processes).to eq(['hello', 'world'])
  end

  it 'searches configuration recursively in parent directories' do
    File.stub(:exist?).and_return(false, false, true)
    File.stub(:read).with("../../#{Fire::DOT_FILE}").and_return(sample_configuration)

    expect(subject.processes).to eq(['hello', 'world'])
  end

  it 'stops searching configuration when root is reached' do
    subject = Fire::ConfigurationResolver.new(stop_at: '/')
    File.stub(:dirname).and_return('/')

    expect { subject.processes }.to raise_error(Fire::ConfigurationNotFound)
  end

  def sample_configuration
    <<-config
    application1: hello
    application2: world
    config
  end
end
