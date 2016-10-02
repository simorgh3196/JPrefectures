//
//  JPrefecturesTests.swift
//  JPrefecturesTests
//
//  Created by Nicholas Maccharoli on 4/3/16.
//  Copyright © 2016 Nicholas Maccharoli. All rights reserved.
//

import XCTest
@testable import JPrefectures

class JPrefecturesTests: XCTestCase {

    //Region
    func testRegionList() {
        XCTAssert(JPrefecture.areaNames.count > 0, "Nil Prefecture List!")
    }

    func testRegionListOrder() {
        let properOrder = ["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州"]
        let libraryOrder = JPrefecture.areaNames

        Zip2Sequence(properOrder, libraryOrder).forEach {
            XCTAssert($0.0 == $0.1, "Region order is wrong.")
        }
    }

    //Prefectures
    func testPrefecture() {
        let prefectureIds = [22,1,47]
        let expectedPrefectureNames = ["Shizuoka", "Hokkaido", "Okinawa"]

        let prefectures = JPrefecture.prefecturesForIds(prefectureIds)?.flatMap { $0 } ?? []

        if prefectures.count == 0 {
            XCTFail("No Prefectures returned for proper Prefecture ID list")
        }

        let returnedNames = prefectures.map { $0.name }
        XCTAssert(returnedNames == expectedPrefectureNames, "List of Prefectures for IDs fails to return proper list.")
    }

    func testAllPrefectures() {
        let prefectures = JPrefecture.allPrefectures()

        if prefectures.count != 47 {
            XCTFail("List of all Prefectures fails to return all Prefecutres.")
        }
    }

    //Regions
    func testRegions() {
        let expectedRegions = ["北海道","関東"]
        if let regions = JPrefecture.prefecturesForIdsByArea([1,13])?.keys {
            XCTAssert(expectedRegions.count == regions.count, "Missing Regionss")
            regions.forEach {
                XCTAssert(expectedRegions.contains($0), "Missing Regionss")
            }
        } else {
            XCTFail("Regions not being returned.")
        }
    }

    func testPrefectureNameInit() {
        let prefecture1 = "Hokkaido"
        let prefecture2 = "Shizuoka"
        let prefecture3 = "tokyo"

        let result1 = Prefecture(name: prefecture1)
        let result2 = Prefecture(name: prefecture2)
        let result3 = Prefecture(name: prefecture3)

        XCTAssert(result1?.code == 1, "Name to prefecture lookup is failing.")
        XCTAssert(result2?.code == 22, "Name to prefecture lookup is failing.")
        XCTAssert(result3?.code == 13, "Name to prefecture lookup is failing.")
    }

    func testPrefectureNameJapaneseInit() {
        let prefecture1 = "北海道"
        let prefecture2 = "静岡県"
        let prefecture3 = "東京都"

        let result1 = Prefecture(nameJapanese: prefecture1)
        let result2 = Prefecture(nameJapanese: prefecture2)
        let result3 = Prefecture(nameJapanese: prefecture3)

        XCTAssert(result1?.code == 1, "Name to prefecture lookup is failing.")
        XCTAssert(result2?.code == 22, "Name to prefecture lookup is failing.")
        XCTAssert(result3?.code == 13, "Name to prefecture lookup is failing.")
    }

    func testPrefectureCodeInit() {
        let prefecture1 = 1
        let prefecture2 = 22
        let prefecture3 = 13

        let result1 = Prefecture(code: prefecture1)
        let result2 = Prefecture(code: prefecture2)
        let result3 = Prefecture(code: prefecture3)

        XCTAssert(result1?.name == "Hokkaido", "Name to prefecture lookup is failing.")
        XCTAssert(result2?.name == "Shizuoka", "Name to prefecture lookup is failing.")
        XCTAssert(result3?.name == "Tokyo", "Name to prefecture lookup is failing.")
    }
}
