require "c/winnt"

@[Link("advapi32")]
lib LibC

  struct WSABUF
    len : ULong
    buf : CHAR*
  end

  struct WSAOVERLAPPED
    internal : ULONG_PTR
    internalHigh : ULONG_PTR
    offset : DWORD
    offsetHigh : DWORD
    hEvent : HANDLE
  end

  alias WINSOCK = ULONG_PTR
  alias LPWSAOVERLAPPED_COMPLETION_ROUTINE = Void*

  fun CreateIoCompletionPort(
    fileHandle : HANDLE, 
    existingCompletionPort : HANDLE, 
    completionKey : ULONG_PTR, 
    numberOfConcurrentThreads : DWORD) : HANDLE

  fun WSARecv(
    socket : WINSOCK, 
    lpBuffers : WSABUF*, 
    dwBufferCount : DWORD, 
    lpNumberOfBytesRecvd : DWORD*,
    lpFlags : DWORD*, 
    lpOverlapped : WSAOVERLAPPED*,
    lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE) : Int32


end