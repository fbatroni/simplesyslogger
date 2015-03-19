# Simplesyslogger

A really simple syslogging utility based on syslogger gem

## Installation

Add this line to your application's Gemfile:

    gem 'simplesyslogger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simplesyslogger

## Usage

Example usage in sinatra:

configure do
	log = SimpleSysLogger::SysLogger.new({
	    :ident => "MY_COOL_APPNAME",
	    :level => Logger::DEBUG #TODO:// # logging level - i.e. send messages that are at least of the Logger::INFO level - not fully implemented yet
	    })

	log.level = ENV['RACK_ENV'] == 'production' ? Logger::INFO : Logger::DEBUG
end

settings.logger.info "app is up and running"

## TODO:

Add some unit tests (RSpec, Travis, Coveralls, etc)


## Contributing

1. Fork it ( https://github.com/[my-github-username]/simplesyslogger/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
