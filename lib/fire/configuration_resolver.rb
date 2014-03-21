require 'yaml'

module Fire
  class ConfigurationResolver
    DOT_FILE = '.fire'

    def processes(path = DOT_FILE)
      return processes("../#{path}") unless File.exist?(path)

      contents = File.read(path)
      YAML.load(contents).values
    end
  end
end
