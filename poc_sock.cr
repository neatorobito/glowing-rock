require "./winsock.cr"

# https://stackoverflow.com/questions/24131843/what-is-makeword-used-for
version = ((2) << 8 | (2))

result = LibC.WSAStartup(version, out wsaData)

if(result != 0)
  puts "WSAStartup failed: #{result}"
else
  puts wsaData.wVersion
  puts wsaData.wHighVersion
end
