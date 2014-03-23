require 'yaml'

module Styoe
  DOT_FILE = '.engines'
  PID_FILE = '.engines.pids'

  class ConfigurationNotFound < StandardError; end

  class ConfigurationResolver
    def initialize(options = {})
      @stop_at = options[:stop_at] || '/'
    end

    def active_processes(path = PID_FILE)
      raise ConfigurationNotFound if stop?(path)
      return active_processes("../#{path}") unless File.exist?(path)

      parse_values(path)
    end

    def processes(path = DOT_FILE)
      raise ConfigurationNotFound if stop?(path)
      return processes("../#{path}") unless File.exist?(path)

      parse_values(path)
    end

    def dump_pids(pids, path = DOT_FILE)
      raise ConfigurationNotFound if stop?(path)
      return dump_pids(pids, "../#{path}") unless File.exist?(path)

      file = File.open(path.gsub(DOT_FILE, PID_FILE), "w")
      file.write(YAML.dump pids)
      file.close
    end

    private

    def parse_values(path)
      contents = File.read(path)
      YAML.load(contents).values
    end

    def stop?(path)
      File.dirname(File.absolute_path path) == @stop_at
    end
  end
end
