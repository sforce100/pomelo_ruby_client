# PomeloClient

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'pomelo_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pomelo_client

## Usage

```
require 'pomelo_client'

p 'test start'
$client = PomeloClient::Client.new('127.0.0.1', '3014')
$client.request('gate.gateHandler.queryEntry', { uid: 1, rid: 1 }) do |msg|
  $client.close
  $client = PomeloClient::Client.new(msg['host'], msg['port'])
  $client.request('connector.entryHandler.enter', { auth_token: '99832fb54a0d602897ce4ce5ed4400d4'}) do |message|
    $client.on('onChat') do |m|
      Rails.logger.info m
    end

    $client.request("chat.chatHandler.send", { content: 'xxoo', from: 'xingxing', type: 'text', gender: '1' }) do |mm|
      Rails.logger.info mm
    end
  end
end

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/pomelo_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
