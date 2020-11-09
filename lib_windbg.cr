require "c/winnt"

lib LibC
  fun IsDebuggerPresent() : Bool
  fun DebugBreak()
end

# Useful pattern
# while !LibC.IsDebuggerPresent
#   sleep 1
# end

# LibC.DebugBreak