# Blastbeat

This is a tiny module for easy integration with the BlastBeat server

## Installation

Add this line to your application's Gemfile:

    gem 'blastbeat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blastbeat

## Usage

```ruby
# connect to a BlastBeat server
blastbeat = BlastBeat::Node.new('tcp://192.168.173.5:5000', 'FOOBAR1')

# send a message to it
blastbeat.send('', 'pong')

# receive a message
sid, msg_type, msg_body = blastbeat.recv
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
