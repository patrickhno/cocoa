# generated by 'rake generate'
require 'cocoa/bindings/NSControl'
module Cocoa
  class NSBrowser < Cocoa::NSControl
    attach_method :acceptsArrowKeys, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :addColumn, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :allowsBranchSelection, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :allowsEmptySelection, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :allowsMultipleSelection, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :allowsTypeSelect, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :autohidesScroller, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :backgroundColor, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :canDragRowsWithIndexes, :args=>3, :names=>[:inColumn, :withEvent], :types=>["@", "q", "@"], :retval=>"B"
    attach_singular_method :cellClass, :args=>0, :names=>[], :types=>[], :retval=>"#"
    attach_method :cellPrototype, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :clickedColumn, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :clickedRow, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :columnContentWidthForColumnWidth, :args=>1, :names=>[], :types=>["d"], :retval=>"d"
    attach_method :columnOfMatrix, :args=>1, :names=>[], :types=>["@"], :retval=>"q"
    attach_method :columnResizingType, :args=>0, :names=>[], :types=>[], :retval=>"Q"
    attach_method :columnWidthForColumnContentWidth, :args=>1, :names=>[], :types=>["d"], :retval=>"d"
    attach_method :columnsAutosaveName, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :defaultColumnWidth, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :delegate, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :displayAllColumns, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :displayColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :doClick, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :doDoubleClick, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :doubleAction, :args=>0, :names=>[], :types=>[], :retval=>":"
    attach_method :draggingImageForRowsWithIndexes, :args=>4, :names=>[:inColumn, :withEvent, :offset], :types=>["@", "q", "@", "^{CGPoint=dd}"], :retval=>"@"
    attach_method :drawTitleOfColumn, :args=>2, :names=>[:inRect], :types=>["q", "{CGRect={CGPoint=dd}{CGSize=dd}}"], :retval=>"v"
    attach_method :editItemAtIndexPath, :args=>3, :names=>[:withEvent, :select], :types=>["@", "@", "B"], :retval=>"v"
    attach_method :firstVisibleColumn, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :frameOfColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :frameOfInsideOfColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :frameOfRow, :args=>2, :names=>[:inColumn], :types=>["q", "q"], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :getRow, :args=>3, :names=>[:column, :forPoint], :types=>["^q", "^q", "{CGPoint=dd}"], :retval=>"B"
    attach_method :hasHorizontalScroller, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :indexPathForColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :isLeafItem, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :isLoaded, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :isTitled, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :itemAtIndexPath, :args=>1, :names=>[], :types=>["@"], :retval=>"@"
    attach_method :itemAtRow, :args=>2, :names=>[:inColumn], :types=>["q", "q"], :retval=>"@"
    attach_method :lastColumn, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :lastVisibleColumn, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :loadColumnZero, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :loadedCellAtRow, :args=>2, :names=>[:column], :types=>["q", "q"], :retval=>"@"
    attach_method :matrixClass, :args=>0, :names=>[], :types=>[], :retval=>"#"
    attach_method :matrixInColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :maxVisibleColumns, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :minColumnWidth, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :noteHeightOfRowsWithIndexesChanged, :args=>2, :names=>[:inColumn], :types=>["@", "q"], :retval=>"v"
    attach_method :numberOfVisibleColumns, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :parentForItemsInColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :path, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :pathSeparator, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :pathToColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :prefersAllColumnUserResizing, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :reloadColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :reloadDataForRowIndexes, :args=>2, :names=>[:inColumn], :types=>["@", "q"], :retval=>"v"
    attach_singular_method :removeSavedColumnsWithAutosaveName, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :reusesColumns, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :rowHeight, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :scrollColumnToVisible, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :scrollColumnsLeftBy, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :scrollColumnsRightBy, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :scrollRowToVisible, :args=>2, :names=>[:inColumn], :types=>["q", "q"], :retval=>"v"
    attach_method :scrollViaScroller, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :selectAll, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :selectRow, :args=>2, :names=>[:inColumn], :types=>["q", "q"], :retval=>"v"
    attach_method :selectRowIndexes, :args=>2, :names=>[:inColumn], :types=>["@", "q"], :retval=>"v"
    attach_method :selectedCell, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :selectedCellInColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :selectedCells, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :selectedColumn, :args=>0, :names=>[], :types=>[], :retval=>"q"
    attach_method :selectedRowInColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"q"
    attach_method :selectedRowIndexesInColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :selectionIndexPath, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :selectionIndexPaths, :args=>0, :names=>[], :types=>[], :retval=>"@"
    attach_method :sendAction, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :sendsActionOnArrowKeys, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :separatesColumns, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :setAcceptsArrowKeys, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setAllowsBranchSelection, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setAllowsEmptySelection, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setAllowsMultipleSelection, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setAllowsTypeSelect, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setAutohidesScroller, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setBackgroundColor, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setCellClass, :args=>1, :names=>[], :types=>["#"], :retval=>"v"
    attach_method :setCellPrototype, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setColumnResizingType, :args=>1, :names=>[], :types=>["Q"], :retval=>"v"
    attach_method :setColumnsAutosaveName, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setDefaultColumnWidth, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setDelegate, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setDoubleAction, :args=>1, :names=>[], :types=>[":"], :retval=>"v"
    attach_method :setDraggingSourceOperationMask, :args=>2, :names=>[:forLocal], :types=>["Q", "B"], :retval=>"v"
    attach_method :setHasHorizontalScroller, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setLastColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :setMatrixClass, :args=>1, :names=>[], :types=>["#"], :retval=>"v"
    attach_method :setMaxVisibleColumns, :args=>1, :names=>[], :types=>["q"], :retval=>"v"
    attach_method :setMinColumnWidth, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setPath, :args=>1, :names=>[], :types=>["@"], :retval=>"B"
    attach_method :setPathSeparator, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setPrefersAllColumnUserResizing, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setReusesColumns, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setRowHeight, :args=>1, :names=>[], :types=>["d"], :retval=>"v"
    attach_method :setSelectionIndexPath, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setSelectionIndexPaths, :args=>1, :names=>[], :types=>["@"], :retval=>"v"
    attach_method :setSendsActionOnArrowKeys, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setSeparatesColumns, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setTakesTitleFromPreviousColumn, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setTitle, :args=>2, :names=>[:ofColumn], :types=>["@", "q"], :retval=>"v"
    attach_method :setTitled, :args=>1, :names=>[], :types=>["B"], :retval=>"v"
    attach_method :setWidth, :args=>2, :names=>[:ofColumn], :types=>["d", "q"], :retval=>"v"
    attach_method :takesTitleFromPreviousColumn, :args=>0, :names=>[], :types=>[], :retval=>"B"
    attach_method :tile, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :titleFrameOfColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"{CGRect={CGPoint=dd}{CGSize=dd}}"
    attach_method :titleHeight, :args=>0, :names=>[], :types=>[], :retval=>"d"
    attach_method :titleOfColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"@"
    attach_method :updateScroller, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :validateVisibleColumns, :args=>0, :names=>[], :types=>[], :retval=>"v"
    attach_method :widthOfColumn, :args=>1, :names=>[], :types=>["q"], :retval=>"d"
  end
end
