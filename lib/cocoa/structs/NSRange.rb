module Cocoa
  class CFRange < FFI::Struct
    def initialize *args
      options = args.first
      if options.is_a? Hash
        self[:location] = options[:location]
        self[:length]   = options[:length]
      else
        super *args
      end
    end
    def to_s
      "<CFRange: #{self[:location]} #{self[:length]}>"
    end
    layout :location, :long_long, :length, :long_long
  end

  NSRange = CFRange

  def CFRangeMake loc,len
    CFRange.new(location: loc, length: len)
  end
end
