require_relative 'spec_helper'
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
    Cocoa::NSString_to_String(array.description.object).should == "(\n    head,\n    tail\n)"
  end
  it 'should return stringifyable strings' do
    array = Cocoa::NSMutableArray.array
    array.addObject "head"
    array.addObject "tail"
    array.description.to_s.should == "(\n    head,\n    tail\n)"
  end
end
