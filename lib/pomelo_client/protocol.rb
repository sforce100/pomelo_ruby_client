module PomeloClient
  module Protocol
    def encode(id, route, msg)
      raise 'route max length is overflow.' if route.length > 255
      arr = []
      arr << ((id >> 24) & 0xFF);
      arr << ((id >> 16) & 0xFF);
      arr << ((id >> 8) & 0xFF);
      arr << (id & 0xFF);
      arr << (route.length() & 0xFF);

      arr += route.bytes.to_a
      return bt2_str(arr) + msg;
    end

    private
    def bt2_str(arr)
      arr.map { |r| r.chr }.join('')
    end
  end
end
