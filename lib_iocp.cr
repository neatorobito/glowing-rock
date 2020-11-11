require "c/winnt"

@[Link("advapi32")]
lib LibC

  type WINSOCK = Int32

  alias LPWSAOVERLAPPED_COMPLETION_ROUTINE = Void*
  # TODO Resolve this in the standard library.

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

  fun WriteFile(
    hFile : HANDLE,
    lpBuffer : Void*,
    nNumberOfBytesToWrite : DWORD,
    lpNumberOfBytesWritten : DWORD*,
    lpOverlapped : WSAOVERLAPPED*
  ) : BOOL

  fun WSARecv(
    socket : WINSOCK, 
    lpBuffers : WSABUF*, 
    dwBufferCount : DWORD, 
    lpNumberOfBytesRecvd : DWORD*,
    lpFlags : DWORD*, 
    lpOverlapped : WSAOVERLAPPED*,
    lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE
  ) : Int

  fun WSAGetLastError() : Int
    
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
    lpOverlapped : WSAOVERLAPPED *
  )

  fun GetQueuedCompletionStatus(
    completionPort : HANDLE,
    lpNumberOfBytesTransferred : DWORD*,
    lpCompletionKey : ULONG_PTR*,
    lpOverlapped : WSAOVERLAPPED*,
    dwMilliseconds : DWORD,
  ) : BOOL

  fun GetQueuedCompletionStatusEx(
    completionPort : HANDLE,
    lpCompletionPortEntries : OVERLAPPED_ENTRY*,
    ulCount : ULong,
    ulNumEntriesRemoved : ULong*,
    dwMilliseconds : DWORD,
    fAlertable : BOOL
    ) : BOOL

end
