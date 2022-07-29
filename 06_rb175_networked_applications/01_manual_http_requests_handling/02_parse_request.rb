require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split
  path, params = path_and_params.split("?")
  
  params = params.split("&").each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept      # listen, open connection

  request_line = client.gets  # read first line HTTP Request
  next if !request_line || request_line =~ /favicon/  # to skip processing empty or favicon request which breaks our parse method

  puts request_line

  http_method, path, params = parse_request(request_line)

  client.puts request_line    # output request line to client for browser
  client.puts http_method
  client.puts path
  client.puts params

  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  rolls.times do
    roll = rand(sides) + 1
    client.puts roll
  end

  client.close                # close TCP connection
end

