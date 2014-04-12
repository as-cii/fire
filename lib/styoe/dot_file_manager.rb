module Styoe
  class ConfigurationNotFound < StandardError; end

  class DotFile < Struct.new(:path, :contents)
    def self.read_from_path(path)
      contents = File.read(path)
      self.new(path, contents)
    end
  end

  class DotFileManager
    def find_recursively(path)
      return DotFile.read_from_path(path) if File.exist?(path)
      raise ConfigurationNotFound if reached_root?(path)

      find_recursively("../#{path}")
    end

    def save_near(filename, new_name: "", contents: "")
      near_file = find_recursively(filename)
      path_to_save = filename_near(near_file.path, new_name)
      write_file(path_to_save, contents)
    end

    private

    def filename_near(path, name)
      filename  = File.basename(path)
      path.gsub(filename, name)
    end

    def write_file(path, contents)
      File.open(path, 'w') { |f| f.write(contents) }
    end

    def reached_root?(path)
      File.dirname(File.absolute_path path) == '/'
    end
  end
end
