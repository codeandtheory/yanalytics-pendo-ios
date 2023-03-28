//
//  PendoEventMappingTests.swift
//  YAnalyticsPendo
//
//  Created by Mark Pospesel on 3/28/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YAnalytics
@testable import YAnalyticsPendo

final class PendoEventMappingTests: XCTestCase {
    func test_default() {
        // Given
        let sut = PendoEventMapping()

        // Then
        XCTAssertTrue(sut.name.isEmpty)
        XCTAssertTrue(sut.topLevelKey.isEmpty)
        XCTAssertEqual(sut.type, .visitor)
    }
    
    func test_defaultScreenView() {
        // Given
        let sut = PendoEventMapping.defaultScreenView

        // Then
        XCTAssertEqual(sut.name, AnalyticsEvent.screenViewKey)
        XCTAssertEqual(sut.topLevelKey, "screenName")
    }
    
    func test_defaultUserProperty() {
        // Given
        let sut = PendoEventMapping.defaultUserProperty

        // Then
        XCTAssertEqual(sut.type, .visitor)
    }

    func test_defaultMapping() {
        // Given
        let sut = PendoEventMapping.default

        // Then
        XCTAssertEqual(sut.count, 2)
        XCTAssertEqual(sut[AnalyticsEvent.screenViewKey], PendoEventMapping.defaultScreenView)
        XCTAssertEqual(sut[AnalyticsEvent.userPropertyKey], PendoEventMapping.defaultUserProperty)
    }
}
