# JPrefectures 
#### *Japanese Prefecture Info on the fly*
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

# Contributing 
Contributions are more than welcome!
If you have an improvement or a feature you wish to have added to JPrefectures, then please don't hesitate to 
send a pull request!

