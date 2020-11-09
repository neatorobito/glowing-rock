require "socket"
require "crystal/system/windows"
require "./lib_windbg"

# version = Crystal::System.make_word(2,2)
version = ((2) << 8 | (2))

def manuallyStartServer()
  socket = Socket.new(Socket::Family::INET6, Socket::Type::STREAM, Socket::Protocol::TCP, false)
  fd = socket.fd

  Socket::Addrinfo.resolve("::1", 60500, socket.family, socket.type, socket.protocol) do | info |
    LibC.bind(fd, info, info.size)
    puts "Bind: #{LibC.WSAGetLastError()}"
  end

  l = LibC.listen(fd, 5)
  puts "Listen: #{LibC.WSAGetLastError()}"

  slice = Slice(UInt8).new(8)
  loop do
    sock = LibC.accept(fd, nil, nil)
    if sock == -1
      puts "Listen: #{LibC.WSAGetLastError()}"
      break
    else
      r = LibC.recv(sock, slice, slice.size, 0)
      puts slice
      puts "Bytes Received: #{r}"
      puts String.new slice
      s = LibC.shutdown(sock, 2)
      puts "Shutdown: #{LibC.WSAGetLastError()}"
    end
  end

  socket.close
end

result = LibC.WSAStartup(version, out wsaData)
if(result != 0)
  puts "WSAStartup failed: #{result}"
  exit
else
  puts "WinSock Version: #{wsaData.wVersion}"
end

# manuallyStartServer
server = TCPServer.new(13500)
if socket = server.accept?
  socket.puts Time.utc
  socket.close
end


LibC.WSACleanup()