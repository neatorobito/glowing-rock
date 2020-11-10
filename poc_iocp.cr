require "./lib_iocp"
require "c/io"
require "c/fcntl"
require "c/fileapi"
require "c/sys/utime"
require "c/sys/stat"
require "c/winbase"

r = Random.new
comp_key = r.next_u
# puts "Completion Key: #{comp_key}"

io_port = LibC.CreateIoCompletionPort(LibC::INVALID_HANDLE_VALUE, nil, 0, 0)

path = "test.txt"
win_path = path.check_no_null_byte.to_utf16.to_unsafe

test_file_hnd = LibC.CreateFileW(
  win_path,
  LibC::GENERIC_READ | LibC::GENERIC_WRITE,
  LibC::FILE_SHARE_READ,
  nil,
  LibC::CREATE_ALWAYS,
  LibC::FILE_ATTRIBUTE_NORMAL | LibC::FILE_FLAG_OVERLAPPED,
  LibC::HANDLE.null
)

fake_data = r.base64((2048) ** 2).to_slice

puts WinError.new(LibC.GetLastError)

if LibC.CreateIoCompletionPort(test_file_hnd, io_port, comp_key, 0) != LibC::INVALID_HANDLE_VALUE

  3.times do 
    ol = LibC::WSAOVERLAPPED.new
    fake_data = r.base64((4096) ** 2).to_slice
    puts LibC.WriteFile(test_file_hnd, fake_data, fake_data.bytesize, out written, pointerof(ol))
    puts WinError.new(LibC.GetLastError)
  end 

  # get_status = LibC.GetQueuedCompletionStatus(io_port, out bytes_trnsfred, out completed, pointerof(ol), LibC::INFINITE)
    get_status = LibC.GetQueuedCompletionStatusEx(io_port, out entries, 3, out removed, LibC::INFINITE, false)

  puts "GetQueuedCompletionStatus : #{get_status}"
  puts WinError.new(LibC.GetLastError)
  puts "Removed Entries: #{removed}"
end

if LibC.CloseHandle(test_file_hnd) == 0
  raise RuntimeError.from_winerror("CloseHandle")
end

if LibC.CloseHandle(io_port) == 0
  raise RuntimeError.from_winerror("CloseHandle")
end
