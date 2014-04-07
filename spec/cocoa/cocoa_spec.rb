require_relative '../spec_helper'
require 'cocoa'

describe 'Cocoa' do
  it 'should lazy load cocoa classes in cocoa derived classes' do
    class Derived < Cocoa::NSObject
      def get_lazy
        NSMenu.new
      end
    end
    Derived.new.get_lazy.class.name.should == 'Cocoa::NSMenu'
  end
  it 'should provide ruby superclass' do
    class Derived < Cocoa::NSObject
    end
    Derived.superclass.name.should == 'Cocoa::NSObject'
  end
  it 'should provide correct return types for class methods' do
    Cocoa::NSMutableArray.array.class.name.should == 'Cocoa::NSMutableArray'
  end
  it 'should provide correct return types for instance methods' do
    array = Cocoa::NSMutableArray.array
    Cocoa::NSMutableArray.array.description.class.name.should == 'Cocoa::NSString'
  end
  it 'should convert NSString to ruby strings' do
    array = Cocoa::NSMutableArray.array
    array.addObject "head"
    array.addObject "tail"
    ObjC.NSString_to_String(array.description.object).should == "(\n    head,\n    tail\n)"
  end
  it 'should return stringifyable strings' do
    array = Cocoa::NSMutableArray.array
    array.addObject "head"
    array.addObject "tail"
    array.description.to_s.should == "(\n    head,\n    tail\n)"
  end

  it 'should call singular methods' do
    Cocoa::NSString.stringWithString('a string').should == 'a string'
  end
  # TODO: known bug
  # it 'should call variadic singular methods' do
  #   Cocoa::NSSet.setWithObjects "A", "B", "and C"
  # end

  it 'should return structs' do
    rect = Cocoa::NSView.alloc.initWithFrame(Cocoa::NSMakeRect(12,34,56,78))
    rect.frame[:origin][:x].should == 12.0
    rect.frame[:origin][:y].should == 34.0
    rect.frame[:size][:width].should == 56.0
    rect.frame[:size][:height].should == 78.0
  end

#  context 'callbacks' do
    it 'should call methods with a argument' do
      class Derived < Cocoa::NSObject
        def foobar foo; end
      end
      derived = Derived.new
      derived.expects(:foobar).with(Cocoa::NSString.stringWithString("a argument"))
      ObjC.msgSend_pointer(derived.object,"foobar:",:pointer,ObjC.String_to_NSString("a argument"))
    end

    it 'should call overridden methods with no arguments' do
      class Derived < Cocoa::NSObject
        def accessibilityActionNames; end
      end
      derived = Derived.new
      derived.expects(:accessibilityActionNames)
      ObjC.msgSend_pointer(derived.object,"accessibilityActionNames")
    end

    it 'should call overridden methods with keword arguments' do
      # fake ruby 2
      unbound_method = mock('UnboundMethod')
      Cocoa::NSObject.expects(:instance_method).with(:tableView).at_least_once.returns(unbound_method)
      unbound_method.expects(:parameters).at_least_once.returns([[:req, :table_view], [:key, :objectValueForTableColumn], [:key, :row]])
      class Derived < Cocoa::NSObject
        #def tableView(table_view, objectValueForTableColumn: column, row: i); end
        def tableView; end
      end

      derived = Derived.new
      derived.expects(:tableView).with(
        Cocoa::NSString.stringWithString("arg1"),
        objectValueForTableColumn: Cocoa::NSString.stringWithString("arg2"),
        row: 123
      )
      ObjC.msgSend_pointer(derived.object,"tableView:objectValueForTableColumn:row:",
        :pointer,ObjC.String_to_NSString("arg1"),
        :pointer,ObjC.String_to_NSString("arg2"),
        :int,123)
    end

    it 'should call overridden methods with keword arguments and return a value' do
      # fake ruby 2
      unbound_method = mock('UnboundMethod')
      Cocoa::NSObject.expects(:instance_method).with(:tableView).at_least_once.returns(unbound_method)
      unbound_method.expects(:parameters).at_least_once.returns([[:req, :table_view], [:key, :objectValueForTableColumn], [:key, :row]])
      class Derived < Cocoa::NSObject
        #def tableView(table_view, objectValueForTableColumn: column, row: i); end
        def tableView *args; "returned value"; end
      end

      derived = Derived.new
      ret = ObjC.msgSend_pointer(derived.object,"tableView:objectValueForTableColumn:row:",
        :pointer,ObjC.String_to_NSString("arg1"),
        :pointer,ObjC.String_to_NSString("arg2"),
        :int,123)
      ObjC.NSString_to_String(ret).to_s.should == "returned value"
    end

    it 'should call overridden methods covered by splat' do
      class Derived < Cocoa::NSObject
        def tableView *args; end
      end

      derived = Derived.new
      derived.expects(:tableView).with(
        Cocoa::NSString.stringWithString("arg1"),
        objectValueForTableColumn: Cocoa::NSString.stringWithString("arg2"),
        row: 123
      )
      ret = ObjC.msgSend_pointer(derived.object,"tableView:objectValueForTableColumn:row:",
        :pointer,ObjC.String_to_NSString("arg1"),
        :pointer,ObjC.String_to_NSString("arg2"),
        :int,123)
    end

#  end
end
