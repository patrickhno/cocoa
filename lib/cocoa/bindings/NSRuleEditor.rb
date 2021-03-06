# generated by 'rake generate'
require 'cocoa/bindings/NSControl'
module Cocoa
  class NSRuleEditor < Cocoa::NSControl
    attach_method :addRow, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :canRemoveAllRows, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :criteriaForRow, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :criteriaKeyPath, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :delegate, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :displayValuesForRow, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :displayValuesKeyPath, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :formattingDictionary, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :formattingStringsFilename, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :insertRowAtIndex, :args=>4, :names=>[:withType, :asSubrowOfRow, :animate], :types=>["q", "Q", "q", "B"], :retval=>"v"
    attach_method :isEditable, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :nestingMode, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :numberOfRows, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :parentRowForRow, :args=>1, :names=>[], :types=>["q"], :retval=>"q"
    attach_method :predicate, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :predicateForRow, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :reloadCriteria, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :reloadPredicate, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :removeRowAtIndex, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :removeRowsAtIndexes, :args=>2, :names=>[:includeSubrows], :types=>["@", "B"], :retval=>"v"
    attach_method :rowClass, :args=>0, :names=>[], :types=>[], :retval=>"#"
    attach_method :rowForDisplayValue, :args=>1, :names=>[], :types=>["@"], :retval=>"q"
    attach_method :rowHeight, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :rowTypeForRow, :args=>1, :names=>[], :types=>["q"], :retval=>"Q"
    attach_method :rowTypeKeyPath, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :selectRowIndexes, :args=>2, :names=>[:byExtendingSelection], :types=>["@", "B"], :retval=>"v"
    attach_method :selectedRowIndexes, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :setCanRemoveAllRows, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setCriteria, :args=>3, :names=>[:andDisplayValues, :forRowAtIndex], :types=>["@", "@", "q"], :retval=>"v"
    attach_method :setCriteriaKeyPath, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setDelegate, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setDisplayValuesKeyPath, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setEditable, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setFormattingDictionary, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setFormattingStringsFilename, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setNestingMode, :args=>1, :names=>[], :types=>["Q"], :retval=>"v"
    attach_method :setRowClass, :args=>1, :names=>[], :types=>["#"], :retval=>"v"
    attach_method :setRowHeight, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setRowTypeKeyPath, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setSubrowsKeyPath, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :subrowIndexesForRow, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :subrowsKeyPath, :args=>0, :names=>[], :types=>[], :retval=>"@"
  end
end
