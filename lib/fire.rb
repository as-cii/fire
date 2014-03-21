require 'fire/version'
require 'fire/configuration_resolver'
require 'fire/process_launcher'

module Fire
  class Launcher
    def initialize(config_resolver = nil, process_launcher = nil)
      @config_resolver  = config_resolver  || ConfigurationResolver.new
      @process_launcher = process_launcher || ProcessLauncher.new
    end

    def start
      @config_resolver.processes.each do |process|
        @process_launcher.launch(process)
      end
    end
  end
end
