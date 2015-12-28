message = "Hello World!\n"
if defined? Truffle
  message << "Running on Truffle!\n"
  if Truffle.graal?
    message << "Running on graal!\n"
  end
end

message << Truffle.graal?

run ->(env) { [200, {"Content-Type" => "text/html"}, [message]] }

