require "./winsock.cr"

# https://stackoverflow.com/questions/24131843/what-is-makeword-used-for
version = ((2) << 8 | (2))
wsaData = LibC::WSAData.new

result = LibC.WSAStartup(version, pointerof(wsaData))

if(result != 0)
  puts "WSAStartup failed: #{result}"
else
  puts "All good, g."
  puts wsaData.wVersion
  puts wsaData.wHighVersion

end
