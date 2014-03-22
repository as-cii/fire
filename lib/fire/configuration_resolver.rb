require 'yaml'

module Fire
  class ConfigurationNotFound < StandardError; end

  class ConfigurationResolver
    DOT_FILE = '.fire'

    def initialize(options = {})
      @stop_at = options[:stop_at] || '/'
    end

    def processes(path = DOT_FILE)
      raise ConfigurationNotFound if stop?(path)
      return processes("../#{path}") unless File.exist?(path)

      contents = File.read(path)
      YAML.load(contents).values
    end

    private

    def stop?(path)
      File.dirname(File.absolute_path path) == @stop_at
    end
  end
end
