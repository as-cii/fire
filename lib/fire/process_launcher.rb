module Fire
  class ProcessLauncher
    def launch(process)
      Process.spawn(process)
    end
  end
end
