//
//  PendoAnalyticsConfiguration.swift
//  YAnalyticsPendo
//
//  Created by Eduardo Moreno Nava on 18/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import Pendo

/// Required parameters for Pendo Analytics Engine
public struct PendoAnalyticsConfiguration {
    /// Application Key to configure with Pendo
    public let appKey: String
    
    /// Information for mapping from `AnalyticsEvent` to Pendo events
    public let mappings: [String: PendoEventMapping]
    
    /// Information required to intilialize a session in Pendo
    public var sessionData: PendoSessionData
    
    /// Turn on/off debug mode in Pendo
    public var debugMode: Bool

    /// Initializes Pendo analytics configuration
    /// - Parameters:
    ///   - appKey: application Key to configure with Pendo
    ///   - mappings: information for mapping from `AnalyticsEvent` to Pendo events
    ///   - sessionData: information required to intilialize a session in Pendo
    ///   - debugMode: turn on/off debug mode in Pendo
    public init(
        appKey: String,
        mappings: [String: PendoEventMapping] = PendoEventMapping.default,
        sessionData: PendoSessionData = PendoSessionData(),
        debugMode: Bool = false
    ) {
        self.appKey = appKey
        self.mappings = mappings
        self.sessionData = sessionData
        self.debugMode = debugMode
    }
}
