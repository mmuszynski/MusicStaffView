# MusicStaffView - *A framework for displaying music in UIKit, Cocoa, and SwiftUI* #

## Overview ##
`MusicStaffView` provides a scheme for displaying a limited set of music notation along a traditional musical staff of five lines. Objects that wish to be drawn in the staff adopt a protocol called `MusicStaffViewElement` which requires them to describe their shape and size in terms of the size of the spaces on the staff. Since the drawing is path-based, and the size depends on the size of the view, `MusicStaffView` is able to offer resolution independence, drawing the best possible shapes in any size view.

## Protocols ##
### MusicStaffViewElement ###
`MusicStaffView` contains a series of objects that adopt the protocol `MusicStaffViewElement`, with its fundamental requirement that the object returns a `CGPath` describing its shape, a height relative to the size of the space between the staff lines, and an aspect ratio describing the shape of its bounding box. `MusicStaffViewElement` provides a default implementation for all other requirements of the protocol, but they allow for further customization of the element.

### MusicStaffViewAccessory ###
A second fundamental protocol, `MusicStaffViewAccessory` (which itself adopts `MusicStaffViewElement`) allows for a `MusicStaffViewElement` to contain child elements that position themselves in certain ways relative to their parent (a simple example being a sharp, flat, or natural in front of a note head). `MusicStaffViewAccessory` elements must conform to `MusicStaffViewElement` for drawing purposes, but they also require more information to describe their position and how they are spaced relative to the parent element.

This particular protocol is still under development and is currently limited in scope.

## Conformance ##
### Music ###
Clearly, `MusicStaffView` requires a description of the music that must be drawn, and thus, there is a core dependency to the framework [Music](https://github.com/mmuszynski/Music).

Many elements of `Music` are provided protocol adoptions. The most important of these currently are the `MusicClef` and `MusicNote` objects (which conform to `MusicStaffViewElement`) and `MusicAccidental` (which conforms to `MusicStaffViewAccessory`).

## Usage ##
### UIKit and Cocoa ###
Using `MusicStaffView` in UIKit and Cocoa requires the use of the class `UIMusicStaffView`, which contains an `elements` property. For example:

    let staffView = UIMusicStaffView(frame: CGRect(x: 0, y: 0, width: 500, height: 200))
    staffView.maxLedgerLines = 3
    staffView.spacing = .preferred
    staffView.elementArray = [MusicClef.treble, MusicPitch.c.octave(4).note(with: .quarter)]
        
![Image of UIMusicStaffView output](/Example Images/uimusicstaffviewexample.png "Example UIMusicStaffView output")

Note that many properties of the view can be customized. See the documentation for more details.

### SwiftUI ###
`MusicStaffView` can also be used in SwiftUI with the class `MusicStaffView`, which uses the SwiftUI `View` protocol to display the staff and its elements. **This is the current focus of development, and as such, many features that exist in the UIKit/Cocoa version are not complete.** However, SwiftUI allows `MusicStaffView` to be deployed in a simpler fashion, thanks to the inclusion of a class that leverages Swift result bulders to create a [domain-specific language (DSL)](https://en.wikipedia.org/wiki/Domain-specific_language) for building staff views:

    MusicStaffView(clef: .treble) {
        MusicPitch.c.octave(4).length(.quarter)
        MusicPitch.d.octave(4).length(.quarter)
        MusicPitch.e.octave(4).length(.quarter)
        MusicPitch.f.accidental(.sharp).octave(4).length(.quarter)
    }
    
    *Image coming eventually.*
    
This allows for idiomatic description of staff view elements, and hopefully a more readable description of music than can be achieved using array-based assignment.

Further, in SwiftUI, various properties of the staff view have been moved into Environment values, allowing for much clearer descriptions of their function:

    MusicStaffView {
        MusicPitch.c.octave(4).length(.quarter)
        MusicPitch.d.octave(4).length(.quarter)
        MusicPitch.e.octave(4).length(.quarter)
        MusicPitch.f.accidental(.sharp).octave(4).length(.quarter)
    }
    .clef(.treble)
    .showNaturalAccidentals(false)
    .lineWidth(10.0)
    
Hopefully, this descriptive language model will lead to more fluent, understandable code.
