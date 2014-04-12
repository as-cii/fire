require 'styoe/version'
require 'styoe/configuration_resolver'
require 'styoe/process_launcher'

module Styoe
  class Launcher
    def initialize(config_resolver, process_launcher)
      @config_resolver  = config_resolver
      @process_launcher = process_launcher
    end

    def self.build(dot_file, pid_file)
      config_resolver = Styoe::ConfigurationResolver.new(dot_file, pid_file, Styoe::DotFileManager.new)
      process_launcher = Styoe::ProcessLauncher.new

      self.new(config_resolver, process_launcher)
    end

    def start
      begin
        processes = Hash[*run_processes]
        @config_resolver.dump_pids(processes)
      rescue ConfigurationNotFound
        $stderr.puts 'No configuration found. Are you sure you have created a .engines file?'
        exit(1)
      end
    end

    def stop
      @config_resolver.active_processes.each do |pid|
        @process_launcher.stop(pid)
      end
    end

    private

    def run_processes
      @config_resolver.processes.map do |process|
        [process, @process_launcher.launch(process)]
      end.flatten
    end
  end
end
