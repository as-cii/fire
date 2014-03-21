require 'minitest/autorun'
require 'fire/configuration_resolver'

describe Fire::ConfigurationResolver do
  subject { Fire::ConfigurationResolver.new }

  it 'resolves and parses a configuration file' do
    File.stub(:exist?, true) do
      File.stub(:read, sample_configuration) do
        subject.processes.must_equal(['hello', 'world'])
      end
    end
  end

  it 'searches configuration recursively in parent directories' do
    File.stub(:read, return_config_on_parent) do
      File.stub(:exist?, return_true_on_parent) do
        subject.processes.must_equal(['hello', 'world'])
      end
    end
  end

  def return_true_on_parent
    -> (path) do
      path.start_with?('../../../')
    end
  end

  def return_config_on_parent
    -> (path) do
      sample_configuration if path.start_with?('../../../')
    end
  end

  def sample_configuration
    <<-config
    application1: hello
    application2: world
    config
  end
end
