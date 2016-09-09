# JPrefectures 
#### *Japanese Prefecture Info on the fly*
![](https://travis-ci.org/Nirma/JPrefectures.svg?branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)



## Usage
####Looking up a single prefecture by:

```swift
//Look up by prefecture Id: 
let tokyo = Prefecture(id: 13)

tokyo.name           // Tokyo
tokyo.nameJapanese   // 東京
tokyo.prefectureId   // 1
tokyo.area           // 関東

//You can also look up by name:
let shizuoka = Prefecture(name: "Shizuoka")

//And also by name in Japanese:
let chiba = Prefecture(nameJapanese: "千葉県")

```
####Get a list of all the prefectures with:

```swift 
let prefectures = JPrefecture.allPrefectures()
```

####Get lists like Region names:

```swift
JPrefectures.regionNames // ["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州"]
```

####Get all prefectures grouped by region:

```swift
JPrefecture.allPrefecturesByRegion()
```
# Swift Version Support
Currently there is a `swift-2.3` branch for Swift 2.3 support and a `swift-3.0` branch for Swift 3.0 support. 
At the time of this writing `master` is currently supporting only Swift 2.2 but if you need Swift 2.3 or Swift 3.0
support ahead of official release feel free to checkout the `swift-2.3` and `swift-3.0` branches instead of master. 

# Contributing 
Contributions are more than welcome!
If you have an improvement or a feature you wish to have added to JPrefectures, then please don't hesitate to 
send a pull request!

