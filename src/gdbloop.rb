
if ARGV.size < 3 then
  STDERR.print "Usage: ruby gdbloop.rb PARENT_PID SERVER_BIN_PATH GDB_BATCH_FILE_PATH\n"
  exit()
end

parent_pid = ARGV[0].to_i
target_program = ARGV[1]
gdb_batch_script = ARGV[2]


#

child_pid = `./pmon5 #{parent_pid}`

print child_pid,"\n"

system("rm logfile;ouch logfile")

30.times {
  sleep 0.2
  system("gdb #{target_program} #{parent_pid} -x #{gdb_batch_script} >> logfile")
}
