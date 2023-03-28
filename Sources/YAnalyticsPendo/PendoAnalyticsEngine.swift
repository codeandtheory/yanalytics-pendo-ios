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
    
    /// Configuration for Pendo analytics
    public var configuration: PendoAnalyticsConfiguration
    
    /// Initialize Pendo engine.
    /// - Parameter configuration: configuration for Pendo Analytics
    public init(configuration: PendoAnalyticsConfiguration) {
        self.mappings = configuration.mappings
        self.configuration = configuration
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
        let mapping = mappings[AnalyticsEvent.screenViewKey] ?? PendoEventMapping.defaultScreenView
        let name = mapping.name
        let userPropertyType = mapping.type
        
        switch event {
        case .screenView(let screenName):
            let data = [mapping.topLevelKey: screenName]
            PendoManager.shared().track(name, properties: data)
        case .userProperty(let propertyName, let value):
            setUserData(type: userPropertyType, propertyName: propertyName, value: value)
        case .event(let eventName, let parameters):
            PendoManager.shared().track(eventName, properties: parameters)
        }
    }
    
    private func setUserData(type: PendoUserPropertyType, propertyName: String, value: String) {
        switch type {
        case .account:
            var data = self.configuration.sessionData.accountData
            data?[propertyName] = value
            PendoManager.shared().setAccountData(data ?? [propertyName: value])
        case .visitor:
            var data = self.configuration.sessionData.visitorData
            data?[propertyName] = value
            PendoManager.shared().setVisitorData(data ?? [propertyName: value])
        }
    }
}
