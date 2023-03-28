//
//  PendoEventMapping.swift
//  YAnalyticsPendo
//
//  Created by Eduardo Moreno Nava on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

/// Information for mapping from `AnalyticsEvent` to Pendo events
public struct PendoEventMapping: Equatable {
    /// Pendo user property type (visitor or account)
    public let type: PendoUserPropertyType
    /// Pendo event name (used when mapping from `AnalyticsEvent.screenView`)
    public let name: String
    /// Top-level key for Pendo event data dictionary (used when mapping from `AnalyticsEvent.screenView`)
    public let topLevelKey: String

    /// Initialize mapping info
    /// - Parameters:
    ///   - name: pendo event name (only used for `AnalyticsEvent.screenView`)
    ///   - topLevelKey: data dictionary top-level key (used only for `AnalyticEvent.screenView`)
    ///   - type: pendo user property type (visitor or account)
    public init(name: String = "", topLevelKey: String = "", type: PendoUserPropertyType) {
        self.name = name
        self.topLevelKey = topLevelKey
        self.type = type
    }
}

public extension PendoEventMapping {
    /// default mapping from `AnalyticsEvent.screenView`
    static let defaultScreenView = PendoEventMapping(
        name: "screenView",
        topLevelKey: "screenName",
        type: .visitor
    )

    /// default mappings from all `AnalyticsEvent` cases to Pendo events
    static let `default`: [String: PendoEventMapping] = [
        "screenView": .defaultScreenView
    ]
}
