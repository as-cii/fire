require 'yaml'

module Fire
  class ConfigurationResolver
    DOT_FILE = '.fire'

    def processes
      contents = File.read(DOT_FILE)
      YAML.load(contents).values
    end
  end
end
