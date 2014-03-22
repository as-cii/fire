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
      begin
        @config_resolver.processes.each do |process|
          @process_launcher.launch(process)
        end
      rescue ConfigurationNotFound
        $stderr.puts 'No configuration found. Are you sure you have created a .fire file?'
        exit(1)
      end
    end

    def stop
      @config_resolver.active_processes.each do |pid|
        @process_launcher.stop(pid)
      end
    end
  end
end
