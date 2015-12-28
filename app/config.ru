module Signal
  # Like Signal.list, but only returns signals that we can actually trap.
  def self.list_trappable
    result = Signal.list.dup
    result.delete("QUIT")
    result.delete("ILL")
    result.delete("FPE")
    result.delete("SEGV")
    result.delete("USR1")
    result.delete("IOT")
    result.delete("EXIT")

    # Don't touch SIGCHLD no matter what! On OS X waitpid() will
    # malfunction if SIGCHLD doesn't have a correct handler.
    result.delete("CLD")
    result.delete("CHLD")

    # Other stuff that we don't want to trap no matter which
    # Ruby engine.
    result.delete("STOP")
    result.delete("KILL")

    return result
  end
end

message = "Hello World!\n"
if defined? Truffle
  message << "Running on Truffle!\n"
  if Truffle.graal?
    message << "Running on graal!\n"
  end
end

run ->(env) { [200, {"Content-Type" => "text/html"}, [message]] }

