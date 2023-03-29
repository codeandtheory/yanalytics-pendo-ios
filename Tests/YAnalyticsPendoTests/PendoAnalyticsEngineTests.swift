//
//  PendoAnalyticsEngineTests.swift
//  YAnalyticsPendo
//
//  Created by Eduardo Moreno Nava on 18/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YAnalyticsPendo
@testable import YAnalytics
@testable import Pendo

final class PendoAnalyticsEngineTests: XCTestCase {
    func test_defaultMapping() throws {
        // Given
        let config = PendoAnalyticsConfiguration(appKey: "S3cr3t!")
        let sut = makeSUT(config: config)
        var data = MockAnalyticsData()
        let engine = try XCTUnwrap(sut.engine as? PendoAnalyticsEngine)
        XCTAssertTrue(sut.mock.allEvents.isEmpty)
        XCTAssertEqual(engine.sessionData.visitorData.count, 0)

        // When
        data.allEvents.forEach { sut.track(event: $0) }

        // Then
        XCTAssertEqual(engine.mappings, PendoEventMapping.default)
        XCTAssertGreaterThan(engine.sessionData.visitorData.count, 0)
        XCTAssertEqual(engine.sessionData.accountData.count, 0)
        XCTAssertEqual(sut.mock.userProperties.count, engine.sessionData.visitorData.count)
        XCTAssertLogged(engine: sut, data: data)
        sut.mock.userProperties.forEach {
            // User properties stored in visitor data by default
            XCTAssertEqual(engine.sessionData.visitorData[$0.0] as? String, $0.1)
        }
    }
    
    func test_customMapping() throws {
        // Given
        let screenView = PendoEventMapping(
            name: "custom",
            topLevelKey: "whatever"
        )
        let userProperty = PendoEventMapping(
            type: .account
        )
        let mapping: [String: PendoEventMapping] = [
            AnalyticsEvent.screenViewKey: screenView,
            AnalyticsEvent.userPropertyKey: userProperty
        ]
        let config = PendoAnalyticsConfiguration(appKey: "S3cr3t!", mappings: mapping)
        let sut = makeSUT(config: config)
        var data = MockAnalyticsData()
        let engine = try XCTUnwrap(sut.engine as? PendoAnalyticsEngine)
        XCTAssertTrue(sut.mock.allEvents.isEmpty)
        XCTAssertEqual(engine.sessionData.accountData.count, 0)

        // When
        data.allEvents.forEach { sut.track(event: $0) }

        // Then
        XCTAssertLogged(engine: sut, data: data)
        XCTAssertGreaterThan(engine.sessionData.accountData.count, 0)
        XCTAssertEqual(engine.sessionData.visitorData.count, 0)
        XCTAssertEqual(sut.mock.userProperties.count, engine.sessionData.accountData.count)
        sut.mock.userProperties.forEach {
            // User properties stored in account data (default is visitor data)
            XCTAssertEqual(engine.sessionData.accountData[$0.0] as? String, $0.1)
        }
    }
    
    func test_emptyMappings_deliversDefaultMappings() throws {
        // Given a configuration with no mappings
        let config = PendoAnalyticsConfiguration(appKey: "S3cr3t!", mappings: [:])
        let sut = makeSUT(config: config)
        var data = MockAnalyticsData()
        let engine = try XCTUnwrap(sut.engine as? PendoAnalyticsEngine)
        XCTAssertTrue(sut.mock.allEvents.isEmpty)
        XCTAssertEqual(engine.sessionData.visitorData.count, 0)

        // When
        data.allEvents.forEach { sut.track(event: $0) }

        // Then
        XCTAssertLogged(engine: sut, data: data)
        XCTAssertGreaterThan(engine.sessionData.visitorData.count, 0)
        XCTAssertEqual(engine.sessionData.accountData.count, 0)
        XCTAssertEqual(sut.mock.userProperties.count, engine.sessionData.visitorData.count)
        sut.mock.userProperties.forEach {
            // User properties stored in visitor data by default
            XCTAssertEqual(engine.sessionData.visitorData[$0.0] as? String, $0.1)
        }
    }
}

private extension PendoAnalyticsEngineTests {
    func makeSUT(
        config: PendoAnalyticsConfiguration,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> SpyAnalyticsEngine {
        let engine = PendoAnalyticsEngine(configuration: config)
        let sut = SpyAnalyticsEngine(engine: engine)
        trackForMemoryLeak(engine, file: file, line: line)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
}
