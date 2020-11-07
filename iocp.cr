require "c/winnt"

@[Link("advapi32")]
lib LibC
  fun CreateIoCompletionPort(fileHandle : HANDLE, existingCompletionPort : HANDLE, completionKey : ULONG_PTR, numberOfConcurrentThreads : DWORD) : HANDLE
  # fun WSARecv(socket : WINSOCK, )
end