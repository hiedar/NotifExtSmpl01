//
//  NotifExtSmpl01Tests.swift
//  NotifExtSmpl01Tests
//
//  Created by 檜枝　龍一 on 2016/11/01.
//
//

import XCTest
@testable import NotifExtSmpl01

class NotifExtSmpl01Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExampleCase1() {
        var isExist = false
        let stations = StationDataService.getHibiyaStations()
        for station in stations {
            if station == "秋葉原駅" {
                isExist = true
            }
        }
        XCTAssert(isExist, "日比谷線に秋葉原駅は存在する?")
    }
    
    func testExampleCase2() {
        var isExist = false
        let stations = StationDataService.getHibiyaStations()
        for station in stations {
            if station == "横浜駅" {
                isExist = true
            }
        }
        XCTAssert(isExist, "日比谷線に横浜駅は存在する?")
    }
}
