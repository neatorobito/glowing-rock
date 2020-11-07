require "c/winnt"

@[Link("advapi32")]
lib LibC

  alias LPWSAOVERLAPPED_COMPLETION_ROUTINE = Void*

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

  struct OVERLAPPED_ENTRY
    lpCompletionKey : ULONG_PTR
    lpOverlapped : WSAOVERLAPPED*
    internal : ULONG_PTR
    dwNumberOfBytesTransferred : DWORD
  end

  fun WSARecv(
    socket : WINSOCK, 
    lpBuffers : WSABUF*, 
    dwBufferCount : DWORD, 
    lpNumberOfBytesRecvd : DWORD*,
    lpFlags : DWORD*, 
    lpOverlapped : WSAOVERLAPPED*,
    lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE
  ) : Int32

  fun WSAGetLastError() : Int32
    
  fun CreateIoCompletionPort(
    fileHandle : HANDLE, 
    existingCompletionPort : HANDLE, 
    completionKey : ULONG_PTR, 
    numberOfConcurrentThreads : DWORD
  ) : HANDLE

  fun PostQueuedCompletionStatus(
    completionPort : HANDLE,
    dwNumberofBytesTransferred : DWORD,
    dwCompletionKey : ULONG_PTR,
    lpOverlapped : WSOVERLAPPED*
  )

  fun GetQueuedCompletionStatus(
    completionPort : HANDLE,
    lpNumberOfBytesTransferred : DWORD*,
    lpCompletionKey : ULONG_PTR,
    lpOverlapped : WSAOVERLAPPED*,
  ) : BOOL

  fun GetQueuedCompletionStatusEx(
    completionPort : HANDLE,
    lpCompletionPortEntries : Slice(OVERLAPPED_ENTRY),
    ulCount : ULONG,
    ulNumEntriesRemoved : ULONG_PTR,
    dwMilliseconds : DWORD,
    fAlertable : BOOL
    ) : BOOL

end