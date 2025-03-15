
# kill sends a signal to terminate a process

kill PID      # send SIGTERM (graceful)
kill -9 PID   # send SIGKILL (forceful)
kill -STOP PID  # pause a process
kill -CONT PID  # resume a paused process
