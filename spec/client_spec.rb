
require 'pomelo_client'

describe PomeloClient do
  it "connect pomelo" do
    p 'test start'
    client = PomeloClient::Client.new('127.0.0.1', '3014')
    sleep(3)
    client.close
    client.request('gate.gateHandler.queryEntry', { uid: 1, rid: 1 }) do |msg|
      client.close
      client = PomeloClient::Client.new(msg['host'], msg['port'])
      client.request('connector.entryHandler.enter', { auth_token: '99832fb54a0d602897ce4ce5ed4400d4'}) do |message|
        p message
      end
    end

    sleep(5)
  end
end