//
//  PendoSessionDataTests.swift
//  YAnalyticsPendo
//
//  Created by Mark Pospesel on 3/28/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YAnalyticsPendo

final class PendoSessionDataTests: XCTestCase {
    func test_default() {
        // Given
        let sut = PendoSessionData()

        // Then
        XCTAssertNil(sut.accountId)
        XCTAssertNil(sut.visitorId)
        XCTAssertTrue(sut.accountData.isEmpty)
        XCTAssertTrue(sut.visitorData.isEmpty)
    }
}
