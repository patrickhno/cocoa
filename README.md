cocoa
=====

Ruby FFI bindings for the OSX Cocoa API

### Installation

```
gem install cocoa
```

### Usage

```ruby
require 'cocoa'
array = Cocoa::NSMutableArray.array
array.addObject "head"
array.addObject "tail"
array.description
=> (
    head,
    tail
)
```
