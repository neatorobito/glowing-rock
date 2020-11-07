require "c/winnt"


@[Link("Ws2_32")]
lib LibC

  struct WSAData
    wVersion : WORD
    wHighVersion : WORD
  end

  fun WSAStartup(
    wVersionRequired : WORD,
    lpWSAData : WSAData*
  ) : Int32

end