require "socket"
require "crystal/system/windows"

version = Crystal::System.make_word(2,2)

result = LibC.WSAStartup(version, out wsaData)

# {% if flag?(:win32) %}
#   raise Socket::Error.new("This type of socket is not supported on Windows.")
# {% end %}

if(result != 0)
  puts "WSAStartup failed: #{result}"
else
  puts "WinSock Version: #{wsaData.wVersion}"
end

client = Socket.new(Socket::Family::INET, Socket::Type::STREAM, Socket::Protocol::TCP, false)
client.connect("localhost", 53540)
client << "Hello from Windows!\n"
response = client.gets
client.close

# client = TCPSocket.new("localhost", 53540)
# client << "Hello again!\n"
# response = client.gets
# client.close

# require "socket"

# def handle_client(client)
#   message = client.gets
#   client.puts message
# end

# server = TCPServer.new("localhost", 1234)
# while client = server.accept?
#   spawn handle_client(client)
# end

LibC.WSACleanup()