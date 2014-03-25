require_relative 'spec_helper'
require 'cocoa'

describe 'Cocoa' do
  it 'should convert NSString to ruby strings' do
    array = Cocoa::NSMutableArray.array
    array.addObject "head"
    array.addObject "tail"
    Cocoa::NSString_to_String(array.description.object).should == "(\n    head,\n    tail\n)"
  end
  it 'should return strings' do
    array = Cocoa::NSMutableArray.array
    array.addObject "head"
    array.addObject "tail"
    array.description.should == "(\n    head,\n    tail\n)"
  end
end
