require 'styoe/version'
require 'styoe/configuration_resolver'
require 'styoe/process_launcher'

module Styoe
  class RunningProcess < Struct.new(:path, :pid)
  end

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
      running_processes = run_processes!
      @config_resolver.dump_processes(running_processes)
    end

    def stop
      @config_resolver.active_processes.each do |pid|
        @process_launcher.stop(pid)
      end
    end

    private

    def run_processes!
      @config_resolver.processes.map do |process_path|
        pid = @process_launcher.launch(process_path)
        RunningProcess.new(process_path, pid)
      end
    end
  end
end
