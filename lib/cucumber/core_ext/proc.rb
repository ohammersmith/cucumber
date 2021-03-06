# Proc extension to get more location info out of a proc
class Proc
  PROC_PATTERN = /[\d\w]+@(.*):(.*)>/
  
  if Proc.new{}.to_s =~ PROC_PATTERN
    def backtrace_line(name)
      "#{file_colon_line}:in `#{name}'"
    end

    def to_comment_line
      "# #{file_colon_line}"
    end

    def file_colon_line
      path, line = *to_s.match(PROC_PATTERN)[1..2]
      path = File.expand_path(path)
      pwd = Dir.pwd
      path = path[pwd.length+1..-1]
      "#{path}:#{line}"
    end
  else
    # This Ruby implementation doesn't implement Proc#to_s correctly
    STDERR.puts "*** THIS RUBY IMPLEMENTATION DOESN'T REPORT FILE AND LINE FOR PROCS ***"
    
    def backtrace_line
      nil
    end

    def to_comment_line
      ""
    end
  end
end 
