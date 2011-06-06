module Chronic
  class Grabber < Tag #:nodoc:
    def self.scan(tokens, options)
      tokens.each_index do |i|
        if t = scan_for_all(tokens[i]) then tokens[i].tag(t); next end
      end
    end

    def self.scan_for_all(token)
      scan_for token, self,
      {
        /last/ => :last,
        /this/ => :this,
        /next/ => :next
      }
    end

    def to_s
      'grabber-' << @type.to_s
    end
  end
end