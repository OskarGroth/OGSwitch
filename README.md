OGSwitch
==================

Layer based Switch Control for macOS, with Interface Builder styling options. Written in Swift.

Supports animation, custom aspect ratios, and knob images.

This is a `NSView` subclass that lets you create beautiful iOS-inspired switches easily.

![OGSwitch for macOS](https://s3.amazonaws.com/cindori/images/ogswitch.png "OGSwitch for macOS")

`OGSwitch` now also supports `IBDesignable` and renders directly in Interface Builder:

![IBDesignable](https://i.imgur.com/BKUyWGg.png "IBDesignable")


## Installation (Carthage)
Configure your Cartfile to use `OGSwitch`:

```github "OskarGroth/OGSwitch" ~> 2.0```

`OGSwitch` requires Swift 4.2.

## Usage

Create a custom `NSView` in Interface Builder and set it's class to `OGSwitch`.
You can now style your switch from the inspector:

![OGSwitch for macOS](https://s3.amazonaws.com/cindori/images/inspector-ogswitch.png "OGSwitch for macOS")

The same values can be accessed from your code.

## Credits

Inspired by ITSwitch by Ilija Tovilo.

## License
The MIT License (MIT)

Copyright (c) 2018 Oskar Groth

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
