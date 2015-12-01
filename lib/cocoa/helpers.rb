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
      @@instances[data.address] ||= ObjC.ffi_to_ruby_value(nil, data, '@')
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
        instance.object = ObjC.msgSend_pointer(instance.klass,method.to_s)
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

    m = ObjC::MethodDef.new(method,params.first)

    params = params.last
    begin
      if params[:args] == 0
        attach_function "call_#{method}".to_sym, method, m.ffi_types, m.ffi_return_type
        define_method method do
          m.ruby_return_value(Lib.send(method))
        end
      else
        attach_function "call_#{method}".to_sym, method, m.ffi_types, m.ffi_return_type
        define_method method do |*args|
          raise ArgumentError.new("#{method} requires #{params[:args]} argument(s)") unless params[:args] == args.size
          m.ruby_return_value(self,send("call_#{method}".to_sym,*m.call_arguments(args)))
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
      return if method == :superclass ||
                method == :class ||
                method == :new

      @@singular_specs ||= {}
      @@singular_specs[method] = []
      [__params].flatten.each do |spec|
        @@singular_specs[method] << ObjC::MethodDef.new(method,spec)
      end

      define_singleton_method method do |*args|
        matching = if args.size <= 1
          matching = @@singular_specs[method].select do |m|
            m.types.size == args.size
          end
        else
          matching = if args.last.is_a? Hash
            @@singular_specs[method].select do |m|
              args.last.keys == m.names
            end
          else
            if args.size == 1
              @@singular_specs[method].select do |m|
                m.types.size == 1
              end
            else
              @@singular_specs[method].select do |m|
                m.variadic? && m.types.size == 1
              end
            end
          end
        end
        raise "hell" unless matching.size == 1
        m = matching.first
        m.call(self,ObjC.objc_getClass(name.split('::').last),*args)
      end
    end

    def self.attach_method method,*_params
      return if method == :class
      @method_specs ||= {}
      @method_specs[method] = []
      [_params].flatten.each do |spec|
        @method_specs[method] << ObjC::MethodDef.new(method,spec)
      end
      define_method method do |*args|
        klass = self.class; klass = klass.superclass while !klass.instance_methods(false).include?(method)
        spec = klass.instance_variable_get(:@method_specs)[method]

        matching = if args.size <= 1
          matching = spec.select do |m|
            m.types.size == args.size
          end
        else
          matching = if args.last.is_a? Hash
            spec.select do |m|
              args.last.keys == m.names
            end
          else
            raise "hell" unless args.size == 1
            spec.select do |m|
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

    def self.method_defs method
      klass = self
      method_specs = klass.instance_variable_get(:@method_specs)
      while klass && (!method_specs || !method_specs[method])
        klass = klass.superclass
        method_specs = klass.instance_variable_get(:@method_specs)
      end
      return unless method_specs

      spec = method_specs[method]
      params = instance_method(method).parameters
      keys = params.select{ |param| param.first == :key }.map{ |param| param.last }
      if params.size > 0 && params.last.first == :rest
        filtered = spec.select do |m|
          ((m.types.size == 0 && keys.size == 0) || (m.types.size > keys.size)) &&
          (m.names[0,keys.size-1] || []) == keys
        end
        return if filtered.size == 0
        filtered
      else
        filtered = spec.select do |m|
          ((m.types.size == 0 && keys.size == 0) || (m.types.size == keys.size+1)) &&
          m.names == keys
        end
        return if filtered.size == 0
        raise filtered.inspect unless filtered.size == 1
        filtered.first
      end
    end

    def self.method_added(name)
      return if name == :== || # TODO: define as equals or something?
                name.to_s[-1] == '=' ||
                caller[1].split('`').last[0..-2] == 'method_added' || # self
                caller.first.split('`').last[0..-2] == 'define_method' || # MRI
                caller.first.split('`').last[0..-2] == 'attach_method' # Rubinius

      # define an alias for keyword argument methods such that:
      # class Foo
      #   def bar whatever, alpha: nil
      #     puts "alpha is: #{alpha}"
      #   end
      #   def bar whatever, omega: nil
      #     puts "omega is: #{omega}"
      #   end
      # end
      # Foo.new.bar "hello", omega: "is omega"
      # Foo.new.bar "hello", alpha: "is alpha"
      #=>
      # omega is: is omega
      # alpha is: is alpha
      keys = instance_method(name).parameters.select{ |param| param.first == :key }.map{ |param| param.last }
      ruby_name = name
      if keys.size > 0
        ruby_name = "_#{name}_with_#{keys.join('_and_')}".to_sym
        alias_method ruby_name, name
      end


      defs = method_defs name
      defs ||= ObjC::MethodDef.new(name, :names => [], :types => ['@'], :retval => 'v')  # TODO: generate from method arguments!

      [defs].flatten.each do |m|
        @callbacks ||= []
        @callbacks << Proc.new do |this,cmd,*args|
          m.ruby_name = ruby_name
          begin
            instance = Cocoa.instances[this.address]
            params = instance_method(ruby_name).parameters
            m.callback(instance,params,args)
          rescue => e
            puts e.message
            puts e.backtrace
          end
        end

        callback_name = "#{self.name.gsub('::','__')}_#{m.selector.gsub(/:/,'_')}".to_sym
        add_method = "add_#{callback_name}".to_sym

        native_name = begin
          arr = self.name.split('::')
          native = if arr.first == 'Cocoa'
            arr.last
          else
            self.name.gsub(/::/,'__')
          end
          native
        end

        ObjC.callback callback_name, [:pointer, :pointer]+m.ffi_types, m.ffi_return_type
        ObjC.attach_function add_method, :class_addMethod, [:pointer,:pointer,callback_name,:string], :void

        ObjC.send(add_method,ObjC.objc_getClass(native_name),ObjC.sel_registerName(m.selector),@callbacks.last,m.objc_types)
      end
    end
  end
end
