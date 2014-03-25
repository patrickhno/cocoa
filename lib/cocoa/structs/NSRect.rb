module Cocoa
  class CGRect < FFI::Struct
    def initialize *args
      options = args.first
      if options.is_a? Hash
        self[:origin][:x] = options[:x]
        self[:origin][:y] = options[:y]
        self[:size][:width] = options[:width]
        self[:size][:height] = options[:height]
      else
        super *args
      end
    end
    layout :origin, CGPoint,
           :size, CGSize
  end

  NSRect = Cocoa::CGRect
end
