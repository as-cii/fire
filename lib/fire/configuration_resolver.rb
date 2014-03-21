require 'yaml'

module Fire
  class ConfigurationNotFound < StandardError; end

  class ConfigurationResolver
    DOT_FILE = '.fire'

    def processes(path = DOT_FILE)
      raise ConfigurationNotFound if File.dirname(path) == '/'
      return processes("../#{path}") unless File.exist?(path)

      contents = File.read(path)
      YAML.load(contents).values
    end
  end
end
