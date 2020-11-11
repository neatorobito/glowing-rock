require "c/winnt"

# Based on the WSAOVERLAPPED structure, see https://docs.microsoft.com/en-us/windows/win32/api/winsock2/ns-winsock2-wsaoverlapped
@[Extern]
struct AsyncOperation
  property token : Int32

  def initialize()
    token = 0
  end

  internal : LibC::ULONG_PTR
  internalHigh : LibC::ULONG_PTR
  offset : LibC::DWORD
  offsetHigh : LibC::DWORD
  hEvent : LibC::HANDLE
end

@[Link("advapi32")]
lib LibC

  type WINSOCK = Int32

  alias LPWSAOVERLAPPED_COMPLETION_ROUTINE = Void*

  struct WSABUF
    len : ULong
    buf : CHAR*
  end

  struct OVERLAPPED_ENTRY
    lpCompletionKey : ULONG_PTR
    lpOverlapped : AsyncOperation*
    internal : ULONG_PTR
    dwNumberOfBytesTransferred : DWORD
  end

  fun WriteFile(
    hFile : HANDLE,
    lpBuffer : Void*,
    nNumberOfBytesToWrite : DWORD,
    lpNumberOfBytesWritten : DWORD*,
    lpOverlapped : AsyncOperation*
  ) : BOOL

  fun WSARecv(
    socket : WINSOCK, 
    lpBuffers : WSABUF*, 
    dwBufferCount : DWORD, 
    lpNumberOfBytesRecvd : DWORD*,
    lpFlags : DWORD*, 
    lpOverlapped : AsyncOperation*,
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
    lpOverlapped : AsyncOperation*
  )

  fun GetQueuedCompletionStatus(
    completionPort : HANDLE,
    lpNumberOfBytesTransferred : DWORD*,
    lpCompletionKey : ULONG_PTR*,
    lpOverlapped : AsyncOperation*,
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
