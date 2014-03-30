
require 'cocoa/objc/method_def'

module ObjC
  extend FFI::Library
 
  ffi_lib 'objc'
 
  attach_function :sel_registerName, [:string], :pointer
  attach_function :objc_msgSend, [:pointer, :pointer, :varargs], :pointer
  attach_function :objc_getClass, [:string], :pointer
  attach_function :objc_allocateClassPair, [:pointer, :string, :int], :pointer
  attach_function :objc_registerClassPair, [:pointer], :void

  def self.msgSend( id, selector, *args )
    selector = sel_registerName(selector) if selector.is_a? String
    objc_msgSend( id, selector, *args )
  end

  def self.msgSend_stret( return_type, id, selector, *args )
    selector = sel_registerName(selector) if selector.is_a? String
    method = "objc_msgSend_stret_for_#{return_type.name.underscore}".to_sym
    unless respond_to? method
      attach_function method, :objc_msgSend_stret, [:pointer, :pointer, :varargs], return_type.by_value
    end
    send(method, id, selector, *args )
  end

  def self.String_to_NSString( string )
    nsstring_class = objc_getClass("NSString")
    msgSend(nsstring_class, "stringWithUTF8String:", :string, string )
  end
 
  def self.NSString_to_String( nsstring_pointer )
    c_string = msgSend( nsstring_pointer, "UTF8String")
    if c_string.null?
      return "(NULL)"
    else
      return c_string.read_string()
    end
  end

  def self.smart_constantize ret,klass_name
    begin
      Cocoa.const_get(klass_name)
    rescue
      _superclass = ObjC.msgSend(ret,'superclass')
      superclass_name = ObjC::NSString_to_String(Cocoa::NSStringFromClass(_superclass))
      superclass = Cocoa::const_get(superclass_name) rescue smart_constantize(_superclass,superclass_name)
      proxy = Class.new(superclass)
      Cocoa.const_set(klass_name, proxy)
      klass = Cocoa.const_get(klass_name)
      superclass.inherited(klass)
      klass
    end
  end

  def self.object_to_instance ret
    klass_name = NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,"class")))
    return self if klass_name == '(NULL)'
    instance = begin
      Cocoa::const_get(klass_name).new(true)
    rescue
      klass_name = if klass_name =~ /^__NSCF/
        "NS#{klass_name[6..-1]}" 
      elsif klass_name[0]=='_'
        if superklass = Cocoa::const_get(NSString_to_String(Cocoa::NSStringFromClass(ObjC.msgSend(ret,"superclass"))))
          superklass.name.split('::').last
        else
          "FIX_#{klass_name}" 
        end
      else
        klass_name
      end
      klass = smart_constantize(ret,klass_name)
      klass.new(true)
    end
    instance.object = ret
    instance
  end

  def self.translate_retval method,ret,type
    case type
    when '@'
      return nil if ret.address == 0
      return ret if method == :NSStringFromClass
      object_to_instance ret
    when '#'
      ret
    when /^{([^=]*)=.*}$/
      ret
    when /^\^{[^=]*=.*}$/
      return nil if ret.address == 0
      object_to_instance ret
    else
      raise type
    end
  end

  def self.apple_type_to_ffi type
    # TODO: These are just stubbed on guess - check'em'all
    case type
    when 'C'
      :uchar
    when '@'
      :pointer
    when '#'
      :pointer
    when 'Q'
      :int
    when ':'
      :pointer
    when 'I'
      :int
    when 'L'
      :int
    when 'd'
      :double
    when 'f'
      :float
    when 'i'
      :int
    when 's'
      :int
    when 'q'
      :long_long
    when 'S'
      :int
    when /^\^/
      :pointer
    when 'B'
      :bool
    when 'v'
      :void
    when '[5*]'
      :void
    when /^{[^=]*=.*}$/
      begin
        /^{_*([^=]*)=.*}$/.match(type)[1].constantize.by_value
      rescue => e
        begin
          "Cocoa::#{/^{_*([^=]*)=.*}$/.match(type)[1]}".constantize.by_value
        rescue => e
          match = /^{_*([^=]*)=(.*)}$/.match(type)
          klass = begin
            Cocoa.const_get(match[1])
          rescue
            # puts "defining struct Cocoa::#{match[1]} as #{match[2]}"
            # this stuff doesnt work with jruby
            klass = Class.new(FFI::Struct)
            Cocoa.const_set(match[1], klass)
            name = 'a'
            layout = []
            match[2].each_char do |c|
              case c
              when 'd'
                layout << name.to_sym
                name = name.next
                layout << :double
              end
            end
            klass = "Cocoa::#{match[1]}".constantize
            klass.layout *layout
            klass
          end
          klass.by_ref
        end
      end
    when nil
      :void
    when '*' # character string
      :pointer
    when '@?'
      :pointer
    else
      raise type.inspect
    end
  end

  def self.objc_type type,default='i'
    case type
    when nil
      default
    when '@', 'v', 'q', 'Q', '^v'
      type
    when /^{([^=]*)=.*}$/
      type
    when /^\^{([^=]*)=.*}$/
      type
    else
      raise type.inspect
    end
  end

  def self.call_arguments params,args
    fixed_args = []
    args.each_with_index do |arg,i|
      case params[:types][i]
      when '@'
        fixed_args << arg
      when 'd'
        if arg.is_a?(Fixnum)
          fixed_args << arg.to_f
        else
          raise ArgumentError.new("float expected, got #{arg.class.name}") unless arg.is_a?(Float)
          fixed_args << arg
        end
      when 'I'
        raise ArgumentError unless arg.is_a?(Fixnum)
        fixed_args << arg
      when 'Q', 'q'
        raise ArgumentError.new(arg.inspect) unless arg.is_a?(Fixnum)
        fixed_args << arg
      when '#'
        raise ArgumentError unless arg.is_a?(FFI::Pointer)
        fixed_args << arg
      when /^{[^=]*=.*}$/
        raise ArgumentError.new(arg.inspect) unless arg.kind_of?(FFI::Struct)
        fixed_args << arg
      when /^\^{([^=]*)=.*}$/
        case arg
        when FFI::Pointer
          fixed_args << arg
        when Array
          raise ArgumentError unless $1 == '__CFArray'
          fixed_args << NSArray.arrayWithObjects(arg).object
        else
          match = $1
          if arg.class.name =~ /^Cocoa::/ # "Cocoa::#{$1}".constantize
            fixed_args << arg.object
          elsif arg.is_a?(NilClass)
            fixed_args << FFI::MemoryPointer::NULL
          elsif arg.is_a?(String) && match == '__CFString'
            fixed_args << Cocoa::String_to_NSString(arg)
          else
            raise ArgumentError.new("expected #{params[:types][i]} got #{arg.class.name} (#{match})")
          end
        end
      when '^d'
        raise ArgumentError unless arg.is_a?(Array)
        arr = FFI::MemoryPointer.new(:double,arg.size)
        arr.write_array_of_double(arg)
        fixed_args << arr
      when '^v'
        raise ArgumentError unless arg.is_a?(NilClass)
        fixed_args << FFI::MemoryPointer::NULL
      else
        raise params[:types][i]
      end
    end
    fixed_args
  end
end
