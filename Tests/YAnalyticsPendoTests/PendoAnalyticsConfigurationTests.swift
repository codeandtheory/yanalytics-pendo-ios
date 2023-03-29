//
//  PendoAnalyticsConfigurationTests.swift
//  YAnalyticsPendo
//
//  Created by Mark Pospesel on 3/28/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YAnalyticsPendo

final class PendoAnalyticsConfigurationTests: XCTestCase {
    func test_defaults() {
        // Given
        let key = "S3cr3t!"
        let sut = PendoAnalyticsConfiguration(appKey: key)

        // Then
        XCTAssertEqual(sut.appKey, key)
        XCTAssertEqual(sut.mappings, PendoEventMapping.default)
        XCTAssertFalse(sut.debugMode)
        XCTAssertNil(sut.sessionData.accountId)
        XCTAssertNil(sut.sessionData.visitorId)
        XCTAssertTrue(sut.sessionData.accountData.isEmpty)
        XCTAssertTrue(sut.sessionData.visitorData.isEmpty)
    }
}
