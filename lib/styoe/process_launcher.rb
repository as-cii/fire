module Styoe
  class ProcessLauncher
    def launch(process)
      Process.spawn(process)
    end

    def stop(pid)
      Process.kill("INT", pid)
    end
  end
end
