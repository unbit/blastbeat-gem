require "blastbeat/version"
require 'zmq'

module BlastBeat
  class Node
    def initialize(server, nodename)
      context = ZMQ::Context.new()
      @socket = context.socket(ZMQ::DEALER)
      @socket.setsockopt(ZMQ::IDENTITY, nodename)
      @socket.connect(server)
      # send a gratuitous pong
      send('', 'pong')
    end

    def recv
      parts = []
      parts << @socket.recv
      if not @socket.getsockopt(ZMQ::RCVMORE)
        return nil
      end
      parts << @socket.recv
      if not @socket.getsockopt(ZMQ::RCVMORE)
        return nil
      end
      parts << @socket.recv
    end

    def send(sid, msg_type, msg_body='')
      @socket.send(sid, ZMQ::SNDMORE)
      @socket.send(msg_type, ZMQ::SNDMORE)
      @socket.send(msg_body)
    end

    def uwsgi(pkt)
      ulen, = pkt[1,2].unpack('v')
      pos = 4
      h = Hash.new
      while pos < ulen
        klen, = pkt[pos,2].unpack('v')
        k = pkt[pos+2, klen]
        pos += 2+klen
        vlen, = pkt[pos,2].unpack('v')
        v = pkt[pos+2, vlen]
        pos += 2+vlen
        h[k] = v
      end
      h
    end
  end
end
