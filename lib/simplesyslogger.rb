require "simplesyslogger/version"

module SimpleSysLogger

  class Logger

    attr_reader :level, :ident, :options, :facility

    MAPPING = {
      Logger::DEBUG => "debug",
      Logger::INFO => "info",
      Logger::WARN => "warning",
      Logger::ERROR => "err",
      Logger::FATAL => "crit",
      Logger::UNKNOWN => "alert"
    }


    def initialize(ident = $0, options = Syslog::LOG_PID | Syslog::LOG_CONS, facility = nil)
      puts "initialize syslogger"
      @ident = ident
      @options = options || (Syslog::LOG_PID | Syslog::LOG_CONS)
      @level = Logger::INFO
      @facility = @facility
    end


    %w{debug info warn error fatal unknown}.each do |logger_method|
      # Accepting *args as message could be nil.
      #  Default params not supported in ruby 1.8.7
      define_method logger_method.to_sym do |*args, &block|
        return true if @level > Logger.const_get(logger_method.upcase)
        message = args.first || block && block.call
        add(Logger.const_get(logger_method.upcase), message)
      end
      unless logger_method == 'unknown'
        define_method "#{logger_method}?".to_sym do
          @level <= Logger.const_get(logger_method.upcase)
        end
      end
    end

    # Sets the minimum level for messages to be written in the log.
    # +level+:: one of <tt>Logger::DEBUG</tt>, <tt>Logger::INFO</tt>, <tt>Logger::WARN</tt>, <tt>Logger::ERROR</tt>, <tt>Logger::FATAL</tt>, <tt>Logger::UNKNOWN</tt>
    def level=(level)
      level = Logger.const_get(level.to_s.upcase) if level.is_a?(Symbol)
      unless level.is_a?(Fixnum)
        raise ArgumentError.new("Invalid logger level `#{level.inspect}`")
      end
      @level = level
    end

    # Low level method to add a message.
    # +severity+::  the level of the message. One of Logger::DEBUG, Logger::INFO, Logger::WARN, Logger::ERROR, Logger::FATAL, Logger::UNKNOWN
    # +message+:: the message string.
    #             If nil, the method will call the block and use the result as the message string.
    #             If both are nil or no block is given, it will use the progname as per the behaviour of both the standard Ruby logger, and the Rails BufferedLogger.
    # +progname+:: optionally, overwrite the program name that appears in the log message.
    def add(severity, message = nil, progname = nil, &block)
      formatted_communication = "=====> #{MAPPING[severity]} :::: #{message}"
      Syslog.open(progname ||  @ident, Syslog::LOG_PID | Syslog::LOG_CONS) { |s|
        puts "#{MAPPING[severity]}  ..... logger:::: #{formatted_communication}"
        #s.warning "logger:::: #{formatted_communication}"
        s.send("#{MAPPING[severity]}".to_sym, formatted_communication)
      }
    end

  end

end
