//
//  PendoEventMapping.swift
//  YAnalyticsPendo
//
//  Created by Eduardo Moreno Nava on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import YAnalytics

/// Information for mapping from `AnalyticsEvent` to Pendo events
public struct PendoEventMapping: Equatable {
    /// Pendo event name (used when mapping from `AnalyticsEvent.screenView`)
    public let name: String
    /// Top-level key for Pendo event data dictionary (used when mapping from `AnalyticsEvent.screenView`)
    public let topLevelKey: String
    /// Pendo user property type (visitor or account) (used when mapping from `AnalyticsEvent.userProperty`)
    public let type: PendoUserPropertyType

    /// Initialize mapping info
    /// - Parameters:
    ///   - name: pendo event name (only used for `AnalyticsEvent.screenView`)
    ///   - topLevelKey: data dictionary top-level key (only used for `AnalyticEvent.screenView`)
    ///   - type: pendo user property type (visitor or account) (only used for `AnalyticEvent.userProperty`)
    public init(name: String = "", topLevelKey: String = "", type: PendoUserPropertyType = .visitor) {
        self.name = name
        self.topLevelKey = topLevelKey
        self.type = type
    }
}

public extension PendoEventMapping {
    /// default mapping from `AnalyticsEvent.screenView`
    static let defaultScreenView = PendoEventMapping(
        name: AnalyticsEvent.screenViewKey,
        topLevelKey: "screenName"
    )

    /// default mapping from `AnalyticsEvent.userProperty`
    static let defaultUserProperty = PendoEventMapping(
        type: .visitor
    )

    /// default mappings from all `AnalyticsEvent` cases to Pendo events
    static let `default`: [String: PendoEventMapping] = [
        AnalyticsEvent.screenViewKey: .defaultScreenView,
        AnalyticsEvent.userPropertyKey: .defaultUserProperty
    ]
}
