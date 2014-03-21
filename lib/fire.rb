require 'fire/version'
require 'fire/configuration_resolver'

module Fire
  class Launcher
    def initialize(config_resolver, process_launcher)
      @config_resolver = config_resolver
      @process_launcher = process_launcher
    end

    def start
      @config_resolver.processes.each do |process|
        @process_launcher.launch(process)
      end
    end
  end
end
