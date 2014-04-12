require 'yaml'
require 'styoe/dot_file_manager'

module Styoe
  class ConfigurationResolver
    def initialize(dot_filename, pid_filename, dot_file_manager)
      @dot_filename = dot_filename
      @pid_filename = pid_filename
      @dot_file_manager = dot_file_manager
    end

    def active_processes
      file_configuration = @dot_file_manager.find_recursively(@pid_filename)

      File.delete(file_configuration.path)
      parse_contents(file_configuration.contents)
    end

    def processes
      file_configuration = @dot_file_manager.find_recursively(@dot_filename)

      parse_contents(file_configuration.contents)
    end

    def dump_pids(pids)
      @dot_file_manager.save_near(@dot_filename,
                                  new_name: @pid_filename,
                                  contents: pids.to_yaml)
    end

    def parse_contents(contents)
      YAML.load(contents).values
    end
  end
end
