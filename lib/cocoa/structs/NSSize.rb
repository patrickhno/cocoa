module Cocoa
  class CGSize < FFI::Struct
    def initialize *args
      options = args.first
      if options.is_a? Hash
        self[:width] = options[:width]
        self[:height] = options[:height]
      else
        super *args
      end
    end
    layout :width, :double,
           :height, :double
  end

  NSSize = CGSize

  def NSMakeSize width,height
    CGSize.new(width: width, height: height)
  end
end
