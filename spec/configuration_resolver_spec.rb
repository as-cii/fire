require 'minitest/autorun'
require 'fire/configuration_resolver'

describe Fire::ConfigurationResolver do
  subject { Fire::ConfigurationResolver.new }

  it 'resolves and parses a configuration file' do
    File.stub(:read, sample_configuration) do
      subject.processes.must_equal(['hello', 'world'])
    end
  end

  def sample_configuration
    <<-config
    application1: hello
    application2: world
    config
  end
end
