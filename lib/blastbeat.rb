require "blastbeat/version"
require 'ffi-rzmq'

module BlastBeat
  class Node
    def initialize(server, nodename, threads=1)
      @context = ZMQ::Context.create(threads)
      @socket = @context.socket(ZMQ::DEALER)
      @socket.setsockopt(ZMQ::IDENTITY, nodename)
      @socket.connect(server)
    end

    def recv
        parts = []
        @socket.recv_strings(parts)
        parts
    end

    def send(sid, msg_type, msg_body='')
      @socket.send_strings([sid, msg_type, msg_body])
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
