module Cocoa
  class CGPoint < FFI::Struct
    def initialize *args
      options = args.first
      if options.is_a? Hash
        self[:x] = options[:x]
        self[:y] = options[:y]
      else
        super *args
      end
    end
    layout :x, :double,
           :y, :double
  end

  NSPoint = CGPoint
end
