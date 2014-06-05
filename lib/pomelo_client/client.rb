
require 'SocketIO'
require 'logging'
require 'json'
require 'debugger'
require "#{File.dirname(__FILE__)}/protocol"

module PomeloClient

  class Client

    include Protocol

    URLHEADER = 'http://'
    JSONARRAY_FLAG = '['
    attr_accessor :req_id, :socket, :logger, :req_id, :cbs, :route_listeners

    def initialize(url, port)
      @req_id = 0
      @cbs = {}
      @route_listeners = {}
      init_socket(url, port)
    end

    def init_socket(url, port)
      url = "#{URLHEADER}#{url}" unless url =~ /http/
      url = "#{url}:#{port}"
      @socket = SocketIO.connect(url, sync: true) do
        before_start do
          on_connect do 
            p "pomeloclient is connected." 
          end
          
          on_error do
            p "connection is error."
            emit("disconnect", nil)
            @socket = nil
          end
          on_disconnect do
            p 'connection is terminated.'
            @socket = nil
          end

          on_heartbeat do
            p 'on_heartbeat...'
          end
        end
      end

      @socket.on_message do |message| 
        p "pomelo send message of string : #{message}" 
        process_message(message)
      end
    end

    def request(route, message, &block)
      @req_id += 1
      @cbs[@req_id] = block
      message = message.to_json if message.class == Hash
      send_message(@req_id, route, message) 
    end

    def send_message(req_id, route, message)
      @socket.send_message(encode(req_id, route, message))
    end

    def on(name, &block)
      if @route_listeners[name] == nil
        @route_listeners[name] = [block]
      else
        @route_listeners[name] << block
      end
    end

    def process_message(data)
      hash_data = JSON.parse(data)
      id = hash_data['id']
      if id != nil
        # request message
        id = id.to_i
        cb = cbs[id]
        cb.call(hash_data['body'])
        cbs.delete(id)
      else
        # broadcast message
        emit(hash_data['route'], hash_data)
      end
    end

    def emit(route, message)
      blocks = @route_listeners[route]
      if blocks != nil
        blocks.each { |block| block.call(message) }
      end
    end

    def close
      @socket.disconnect
    end

  end
end