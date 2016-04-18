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
        print(JPrefecture.regionNames)
        XCTAssert(JPrefecture.regionNames.count > 0, "Nil Prefecture List!")
    }

    func testRegionListOrder() {
        let properOrder = ["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州"]
        let libraryOrder = JPrefecture.regionNames

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

        let returnedNames = prefectures.map { $0.nameRoman }
        XCTAssert(returnedNames == expectedPrefectureNames, "List of Prefectures for IDs fails to return proper list.")
    }

    //Regions
    func testRegions() {
        let expectedRegions = ["北海道","関東"]
        if let regions = JPrefecture.prefecturesForIdsByRegion([1,13])?.keys {
            XCTAssert(expectedRegions.count == regions.count, "Missing Regionss")
            regions.forEach {
                XCTAssert(expectedRegions.contains($0), "Missing Regionss")
            }
        } else {
            XCTFail("Regions not being returned.")
        }
    }

    func testPrefNameLookup() {
        let prefecture1 = "Hokkaido"
        let prefecture2 = "Shizuoka"
        let prefecture3 = "tokyo"

        let result1 = JPrefecture.prefectureIdForName(prefecture1)
        let result2 = JPrefecture.prefectureIdForName(prefecture2)
        let result3 = JPrefecture.prefectureIdForName(prefecture3)

        XCTAssert(result1 == 1, "Name to prefecture lookup is failing.")
        XCTAssert(result2 == 22, "Name to prefecture lookup is failing.")
        XCTAssert(result3 == 13, "Name to prefecture lookup is failing.")
    }
}
