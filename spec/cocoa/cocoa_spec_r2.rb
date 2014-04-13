require_relative '../spec_helper'
require 'cocoa'

describe 'Cocoa' do
#  context 'callbacks' do
    it 'should be able to call overridden methods with keword arguments and return a value' do
      class Derived < Cocoa::NSObject
        def tableView(table_view, objectValueForTableColumn: column, row: i)
          "returned value"
        end
      end

      derived = Derived.new
      ret = derived.tableView("arg1", objectValueForTableColumn: "arg2", row: 123)
      ret.to_s.should == "returned value"
    end
#  end
end
