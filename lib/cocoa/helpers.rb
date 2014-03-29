require 'active_support/inflector'
require 'ffi'
require 'cocoa/objc'

module Cocoa; end

require 'cocoa/structs/NSPoint'
require 'cocoa/structs/NSSize'
require 'cocoa/structs/NSRect'
require 'cocoa/structs/NSRange'

module Cocoa

  def instances
    @@instances ||= {}
  end
  def instance_for data
    if data.is_a?(FFI::Pointer)
      @@instances[data.address] ||= ObjC.translate_retval nil,data,'@'
    else
      data
    end
  end

  def self.attach_nsstring_getter method
    raw = "get_objc_#{method}".to_sym
    attach_variable raw, method, :pointer
    if /[A-Z]/ =~ method.to_s[0]
      Cocoa.const_set(method,ObjC.NSString_to_String(send(raw)))
    else
      define_singleton_method method do
        ObjC.NSString_to_String(send(raw))
      end
    end
  end

  def self.attach_singular_method method,*params
    params = params.extract_options!
    params.freeze
    if params[:args] == 0
      define_singleton_method method do
        instance = new(true)
        instance.object = ObjC.msgSend(instance.klass,method.to_s)
        instance
      end
    else
      define_singleton_method method do |*args|
        raise "hell"
      end
    end
  end

  def self.attach_method method,*params
    if params.first.is_a? Array
      params = params.last
    end

    params = params.extract_options!
    params.freeze
    begin
      if params[:args] == 0
        attach_function "call_#{method}".to_sym, method, [], ObjC.apple_type_to_ffi(params[:retval])
        define_method method do
          case params[:retval]
          when /^\^{[^=]*=.*}$/
            Cocoa::translate_retval(method,send("call_#{method}".to_sym),params[:retval])
          else
            raise params.inspect
          end
        end
      else
        attach_function "call_#{method}".to_sym, method, params[:types].map{ |arg| ObjC.apple_type_to_ffi(arg) }, ObjC.apple_type_to_ffi(params[:retval])
        define_method method do |*args|
          raise ArgumentError.new("#{method} requires #{params[:args]} argument(s)") unless params[:args] == args.size
          ret = send("call_#{method}".to_sym,*ObjC.call_arguments(params,args))
          if params[:retval]=='v'
            self
          else
            ObjC.translate_retval(method,ret,params[:retval])
          end
        end
      end
    rescue FFI::NotFoundError => e
    end
  end
  extend self

  class NSObject
    attr_accessor :klass
    attr_reader :object

    def self.attach_singular_method method,*__params
      return if method == :superclass

      __params.freeze
      return if method==:class
      return if method==:new
      if __params.first.is_a?(Hash) && __params.first[:args] == 0
        define_singleton_method method do
          instance = new(true)
          instance.object = ObjC.msgSend(instance.klass,method.to_s)
          instance
        end
      else
        _params = [__params.dup].flatten
        _params.freeze
        define_singleton_method method do |*args|
          par = if _params.size == 1 && _params.first[:variadic]
            _params
          else
            _params.select{ |par| (par[:args] == 1 && args.size == 1) || (par[:args] == args.last.size+1 && par[:names].map(&:to_sym).sort == args.last.keys.sort) }
          end
          raise ArgumentError unless par.size == 1
          params = par.dup.extract_options!

          options = args.extract_options!
          fixed_args = if params[:variadic]
            raise "not yet supported" unless params[:types].size == 1
            NSObject.fixed_args(args,options,params[:types],params)
          else
            NSObject.fixed_args(args,options,params[:types])
          end
          ret = ObjC.msgSend(ObjC.objc_getClass(name.split('::').last),"#{method}#{(['']+params[:names]).join(':')}:",*fixed_args)
          case params[:retval]
          when '@'
            return nil if ret.address == 0
            ObjC.object_to_instance(ret)
          when 'v'
            self
         else
            raise params[:retval]
          end
        end
      end
    end

    def self.attach_method method,*_params
      return if method==:class
      @@method_specs ||= {}
      @@method_specs[method] = []
      [_params].flatten.each do |spec|
        @@method_specs[method] << ObjC::MethodDef.new(method,spec)
      end
      define_method method do |*args|
        matching = if args.size <= 1
          matching = @@method_specs[method].select do |m|
            m.types.size == args.size
          end
        else
          matching = if args.last.is_a? Hash
            @@method_specs[method].select do |m|
              args.last.keys == m.names
            end
          else
            raise "hell" unless args.size == 1
            @@method_specs[method].select do |m|
              m.types.size == 1
            end
          end
        end
        raise "hell" unless matching.size == 1
        m = matching.first
        m.call(self,@object,*args)
      end
    end

    def object= obj
      Cocoa::instances[obj.address] = self
      @object = obj
    end

    def self.method_def method
      return nil unless @@method_specs[method]
      keys = instance_method(method).parameters.select{ |param| param.first == :key }.map{ |param| param.last }
      filtered = @@method_specs[method].select do |m|
        m.types.size == keys.size+1 &&
        m.names == keys
      end
      return nil if filtered.size == 0
      unless filtered.size == 1
        raise filtered.inspect
      end
      filtered.first
    end

    def self.method_added(name)
      return if caller.first.split('`').last[0..-2] == 'define_method'  # MRI
      return if caller.first.split('`').last[0..-2] == 'attach_method'  # Rubinius
      method_definition = "#{self.name.gsub('::','__')}_#{name}".to_sym
      add_method = "add_#{method_definition}".to_sym

      @method_callers ||= {}
      raise "allready added" if @method_callers[method_definition]
      @method_callers[method_definition] = Proc.new do |this,cmd,*args|
        begin
          instance = Cocoa.instances[this.address]
          instance.send(name,*args.map{ |arg| Cocoa::instance_for(arg) })
        rescue => e
          puts e.message
          puts e.backtrace
        end
      end

      m = method_def name
      m ||= ObjC::MethodDef.new(name, :names => [], :types => ['@'], :retval => 'v')  # TODO: generate from method arguments!

      ObjC.callback method_definition, [:pointer, :pointer]+m.ffi_types, m.ffi_return_type
      ObjC.attach_function add_method, :class_addMethod, [:pointer,:pointer,method_definition,:string], :void

      ObjC.send(add_method,ObjC.objc_getClass(self.name.split('::').last),ObjC.sel_registerName("#{name}:"),@method_callers[method_definition],m.objc_types)
    end
  end
end
