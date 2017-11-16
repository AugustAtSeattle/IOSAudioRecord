# Audio Record Example 
in Swift 4 by using AVFoundation Framework


## Getting Started

1. Xcode 9
2. Swift4

## Verify the record file
get path of record file in the simulator
```swift
   #if arch(i386) || arch(x86_64)
       let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as! NSString
       NSLog("Document Path: %@", documentsPath)
   #endif
```
## Versioning

1.0

## Authors

* **August Lin** - *Initial work* - [github](https://github.com/AugustAtSeattle/)

Email: august dot lin dot usa @ gmail dot com
