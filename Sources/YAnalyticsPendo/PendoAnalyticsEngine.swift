//
//  PendoAnalyticsEngine.swift
//  YAnalyticsPendo
//
//  Created by Eduardo Moreno Nava on 18/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import Pendo
import YAnalytics

/// Pendo Analytics Engine
final public class PendoAnalyticsEngine {
    /// Info for mapping `AnalyticsEvent` events to Pendo events
    public let mappings: [String: PendoEventMapping]
    
    /// Session data for user properties (we need to accumulate over app lifecycle)
    private(set) public var sessionData: PendoSessionData
    
    /// Initialize Pendo engine.
    /// - Parameter configuration: configuration for Pendo Analytics
    public init(configuration: PendoAnalyticsConfiguration) {
        self.mappings = configuration.mappings
        self.sessionData = configuration.sessionData
        PendoManager.shared().setup(configuration.appKey)
        PendoManager.shared().setDebugMode(configuration.debugMode)
        let session = configuration.sessionData
        PendoManager.shared().startSession(
            session.visitorId,
            accountId: session.accountId,
            visitorData: session.visitorData,
            accountData: session.accountData
        )
    }
}

extension PendoAnalyticsEngine: AnalyticsEngine {
    /// Track an analytics event
    /// - Parameter event: the event to log
    public func track(event: AnalyticsEvent) {
        switch event {
        case .screenView(let screenName):
            let mapping = mappings[AnalyticsEvent.screenViewKey] ?? PendoEventMapping.defaultScreenView
            let name = mapping.name
            let data = [mapping.topLevelKey: screenName]
            PendoManager.shared().track(name, properties: data)
        case .userProperty(let propertyName, let value):
            let mapping = mappings[AnalyticsEvent.userPropertyKey] ?? PendoEventMapping.defaultUserProperty
            let userPropertyType = mapping.type
            setUserData(type: userPropertyType, propertyName: propertyName, value: value)
        case .event(let eventName, let parameters):
            PendoManager.shared().track(eventName, properties: parameters)
        }
    }
    
    private func setUserData(type: PendoUserPropertyType, propertyName: String, value: String) {
        switch type {
        case .account:
            sessionData.accountData[propertyName] = value
            PendoManager.shared().setAccountData(sessionData.accountData)
        case .visitor:
            sessionData.visitorData[propertyName] = value
            PendoManager.shared().setVisitorData(sessionData.visitorData)
        }
    }
}
