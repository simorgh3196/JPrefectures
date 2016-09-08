//
//  Prefectures.swift
//  Prefectures
//
//  Created by Nicholas Maccharoli on 4/3/16.
//  Copyright © 2016 Nicholas Maccharoli. All rights reserved.
//

import Foundation

public struct Prefecture {
    public let name: String
    public let nameJapanese: String
    public let code: Int
    public let area: String

    internal init(name: String, nameJapanese: String, code: Int, area: String) {
        self.name = name
        self.nameJapanese = nameJapanese
        self.code = code
        self.area = area
    }
}


//MARK: - Initializers

extension Prefecture {

    public init?(name: String) {
        if let prefecture = JPrefecture.prefectureForName(name) {
            self = prefecture
            return
        }

        return nil
    }

    public init?(code: Int) {
        if let prefecture = JPrefecture.prefectureForPrefectureCode(code) {
            self = prefecture
            return
        }

        return nil
    }

    public init?(nameJapanese: String) {
        if let prefecture = JPrefecture.prefectureForPrefectureNameJapanese(nameJapanese) {
            self = prefecture
            return
        }

        return nil
    }
}


// MARK: - General Prefecture info lookup class

open class JPrefecture {

    open static var areaNames: [String] {
        return area.flatMap { $0.keys.first }
    }

    internal static func prefectureForPrefectureCode(_ prefectureCode: Int) -> Prefecture? {
        guard prefectureCodeIsValid(prefectureCode) else { return nil }

        return mapDictionaryToPrefecture(prefectures[(prefectureCode - 1)])
    }

    internal static func prefectureForName(_ prefectureName: String) -> Prefecture? {
        return prefectureMatchingValueForKey("name", target: prefectureName)
    }

    internal static func prefectureForPrefectureNameJapanese(_ prefectureNameJapanese: String) -> Prefecture? {
        return prefectureMatchingValueForKey("name_ja", target: prefectureNameJapanese)
    }

    open static func prefecturesForIds(_ prefectureCodes: [Int]) -> [Prefecture]? {
        var result = [Prefecture]()
        for prefectureCode in prefectureCodes {
            guard prefectureCodeIsValid(prefectureCode) else { return nil }
            let zeroBasedId = prefectureCode - 1
            result += [mapDictionaryToPrefecture(prefectures[zeroBasedId])]
        }
        
        return result.count > 0 ? result : nil
    }
    
    open static func prefecturesForIdsByArea(_ prefectureCodes: [Int]) -> [String: [Prefecture]]? {
        guard let prefectures = prefecturesForIds(prefectureCodes) else { return nil }
        
        var groupedPrefectures = [String: [Prefecture]]()
        for area in areaNames {
            let prefs = prefectures.filter { $0.area == area }
            guard prefs.count > 0 else { continue }
            groupedPrefectures[area] = prefs
        }
        
        return groupedPrefectures
    }
}


// MARK: - Dictionary Lookup

extension JPrefecture {

    internal static func prefectureMatchingValueForKey(_ key: String, target: String) -> Prefecture? {
        let target = target.lowercased()
        for prefecture in prefectures where prefecture[key]?.lowercased() == target {
            return mapDictionaryToPrefecture(prefecture)
        }

        return nil
    }

    internal static func mapDictionaryToPrefecture(_ dic: [String: String]) -> Prefecture {
        let name = dic["name"]!
        let nameJapanese = dic["name_ja"]!
        let prefectureCode = Int(dic["pref_id"]!)!
        let area = dic["area"]!

        return Prefecture(
            name: name,
            nameJapanese: nameJapanese,
            code: prefectureCode,
            area: area
        )
    }

    internal static func prefectureCodeIsValid(_ prefectureCode: Int) -> Bool {
        guard (1..<48).contains(prefectureCode) else { return false }
        return true
    }
}


// MARK: - Private Data Backing Store

private let area = [
    ["北海道": ["Hokkaido"]],
    ["東北": ["Akita", "Fukushima", "Aomori", "Miyagi", "Yamagata", "Iwate"]],
    ["関東": ["Tokyo", "Chiba", "Tochigi", "Gunma", "Ibaraki", "Saitama", "Kanagawa"]],
    ["中部": ["Aichi", "Ishikawa", "Toyama", "Fukui", "Nagano", "Yamanashi", "Shizuoka", "Niigata", "Gifu"]],
    ["関西": ["Kyoto", "Shiga", "Mie", "Nara", "Wakayama", "Hyogo", "Osaka"]],
    ["中国": ["Shimane", "Hiroshima", "Tottori", "Okayama", "Yamaguchi"]],
    ["四国": ["Kochi", "Kagawa", "Tokushima", "Ehime"]],
    ["九州": ["Saga", "Kagoshima", "Okinawa", "Miyazaki", "Nagasaki", "Oita", "Kumamoto", "Fukuoka"]],
]

private let prefectures = [
    ["name": "Hokkaido", "name_ja": "北海道", "pref_id": "1", "area": "北海道"],
    ["name": "Aomori", "name_ja": "青森県", "pref_id": "2", "area": "東北"],
    ["name": "Iwate", "name_ja": "岩手県", "pref_id": "3", "area": "東北"],
    ["name": "Miyagi", "name_ja": "宮城県", "pref_id": "4", "area": "東北"],
    ["name": "Akita", "name_ja": "秋田県", "pref_id": "5", "area": "東北"],
    ["name": "Yamagata", "name_ja": "山形県", "pref_id": "6", "area": "東北"],
    ["name": "Fukushima", "name_ja": "福島県", "pref_id": "7", "area": "東北"],
    ["name": "Ibaraki", "name_ja": "茨城県", "pref_id": "8", "area": "関東"],
    ["name": "Tochigi", "name_ja": "栃木県", "pref_id": "9", "area": "関東"],
    ["name": "Gunma", "name_ja": "群馬県", "pref_id": "10", "area": "関東"],
    ["name": "Saitama", "name_ja": "埼玉県", "pref_id": "11", "area": "関東"],
    ["name": "Chiba", "name_ja": "千葉県", "pref_id": "12", "area": "関東"],
    ["name": "Tokyo", "name_ja": "東京都", "pref_id": "13", "area": "関東"],
    ["name": "Kanagawa", "name_ja": "神奈川県", "pref_id": "14", "area": "関東"],
    ["name": "Niigata", "name_ja": "新潟県", "pref_id": "15", "area": "中部"],
    ["name": "Toyama", "name_ja": "富山県", "pref_id": "16", "area": "中部"],
    ["name": "Ishikawa", "name_ja": "石川県", "pref_id": "17", "area": "中部"],
    ["name": "Fukui", "name_ja": "福井県", "pref_id": "18", "area": "中部"],
    ["name": "Yamanashi", "name_ja": "山梨県", "pref_id": "19", "area": "中部"],
    ["name": "Nagano", "name_ja": "長野県", "pref_id": "20", "area": "中部"],
    ["name": "Gifu", "name_ja": "岐阜県", "pref_id": "21", "area": "中部"],
    ["name": "Shizuoka", "name_ja": "静岡県", "pref_id": "22", "area": "中部"],
    ["name": "Aichi", "name_ja": "愛知県", "pref_id": "23", "area": "中部"],
    ["name": "Mie", "name_ja": "三重県", "pref_id": "24", "area": "関西"],
    ["name": "Shiga", "name_ja": "滋賀県", "pref_id": "25", "area": "関西"],
    ["name": "Kyoto", "name_ja": "京都府", "pref_id": "26", "area": "関西"],
    ["name": "Osaka", "name_ja": "大阪府", "pref_id": "27", "area": "関西"],
    ["name": "Hyogo", "name_ja": "兵庫県", "pref_id": "28", "area": "関西"],
    ["name": "Nara", "name_ja": "奈良県", "pref_id": "29", "area": "関西"],
    ["name": "Wakayama", "name_ja": "和歌山県", "pref_id": "30", "area": "関西"],
    ["name": "Tottori", "name_ja": "鳥取県", "pref_id": "31", "area": "中国"],
    ["name": "Shimane", "name_ja": "島根県", "pref_id": "32", "area": "中国"],
    ["name": "Okayama", "name_ja": "岡山県", "pref_id": "33", "area": "中国"],
    ["name": "Hiroshima", "name_ja": "広島県", "pref_id": "34", "area": "中国"],
    ["name": "Yamaguchi", "name_ja": "山口県", "pref_id": "35", "area": "中国"],
    ["name": "Tokushima", "name_ja": "徳島県", "pref_id": "36", "area": "四国"],
    ["name": "Kagawa", "name_ja": "香川県", "pref_id": "37", "area": "四国"],
    ["name": "Ehime", "name_ja": "愛媛県", "pref_id": "38", "area": "四国"],
    ["name": "Kochi", "name_ja": "高知県", "pref_id": "39", "area": "四国"],
    ["name": "Fukuoka", "name_ja": "福岡県", "pref_id": "40", "area": "九州"],
    ["name": "Saga", "name_ja": "佐賀県", "pref_id": "41", "area": "九州"],
    ["name": "Nagasaki", "name_ja": "長崎県", "pref_id": "42", "area": "九州"],
    ["name": "Kumamoto", "name_ja": "熊本県", "pref_id": "43", "area": "九州"],
    ["name": "Oita", "name_ja": "大分県", "pref_id": "44", "area": "九州"],
    ["name": "Miyazaki", "name_ja": "宮崎県", "pref_id": "45", "area": "九州"],
    ["name": "Kagoshima", "name_ja": "鹿児島県", "pref_id": "46", "area": "九州"],
    ["name": "Okinawa", "name_ja": "沖縄県", "pref_id": "47", "area": "九州"],
]
