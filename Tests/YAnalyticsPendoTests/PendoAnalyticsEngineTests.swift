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
    func test_init() {
        let config = PendoAnalyticsConfiguration(appKey: "NoMappingsTest")
        let sut = makeSUT(config: config)
        XCTAssertNotNil(sut)
    }
    
    func test_defaultMapping() {
        let config = PendoAnalyticsConfiguration(appKey: "NoMappingsTest")
        let mappings = config.mappings
        XCTAssertEqual(mappings[AnalyticsEvent.screenViewKey], PendoEventMapping.defaultScreenView)
    }
    
    func test_customMapping() {
        let screenView = PendoEventMapping(
            name: "screenView",
            topLevelKey: "screenName",
            type: .account
        )

        let mapping: [String: PendoEventMapping] = ["screenView": screenView]
        let customConfig = PendoAnalyticsConfiguration(appKey: "NoMappingsTest", mappings: mapping)
        
        let sut = makeSUT(config: customConfig)
        var data = MockAnalyticsData()

        XCTAssertNotNil(sut.mock.allEvents.isEmpty)
        
        // We should still be able to track by falling
        // back on default mappings
        data.allEvents.forEach { sut.track(event: $0) }
        
        XCTAssertLogged(engine: sut, data: data)
    }
    
    func test_defaultMappings() {
        // Given a configuration with no mappings
        let noMappingsConfig = PendoAnalyticsConfiguration(appKey: "NoMappingsTest", mappings: [:])
        let sut = makeSUT(config: noMappingsConfig)
        var data = MockAnalyticsData()
        
        XCTAssert(sut.mock.allEvents.isEmpty)
        // We should still be able to track by falling
        // back on default mappings
        data.allEvents.forEach { sut.track(event: $0) }
        
        XCTAssertLogged(engine: sut, data: data)
    }
    
    func test_optionsParameters() throws {
        // Given
        let config = PendoAnalyticsConfiguration(appKey: "sEcr3t")
        let sut = makeSUT(config: config)
        var data = MockAnalyticsData()

        XCTAssert(sut.mock.allEvents.isEmpty)

        // When
        data.allEvents.forEach { sut.track(event: $0) }

        // Then
        XCTAssertNotNil(PendoManager.shared())
        XCTAssertNotNil(config.appKey)
        XCTAssertEqual(config.mappings, PendoEventMapping.default)
        XCTAssertLogged(engine: sut, data: data)
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
