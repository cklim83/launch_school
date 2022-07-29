require "socket"

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept      # open connection
  
  request_line = client.gets  # read http request line
  puts request_line           # output request line to server console

  # Add status and headers for browsers that require proper response format
  # client.puts "HTTP/1.1 200 OK"
  # client.puts "Content-Type: text/plain\r\n\r\n"

  client.puts request_line    # send request line as response to client
  client.close                # close connection
end
