require 'Devenv/app'
module Devenv
  class Runner
    def initialize( argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel )
      @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
    end

    def execute!
      begin
        $stderr = @stderr
        $stdin  = @stdin
        $stdout = @stdout

        Devenv::App.start( @argv )
      rescue StandardError => e
        b = e.backtrace
        b.unshift( "#{b.shift}: #{e.message} (#{e.class})" )
        @stderr.puts( b.map { |s| "\tfrom #{s}" }.join( "\n" ) )
      ensure
        $stderr = STDERR
        $stdin  = STDIN
        $stdout = STDOUT
      end
    end
  end
end
