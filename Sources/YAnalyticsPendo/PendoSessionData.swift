//
//  PendoSessionData.swift
//  YAnalyticsPendo
//
//  Created by Eduardo Moreno Nava on 19/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

/// Session data information
public struct PendoSessionData {
    /// visitor id
    public var visitorId: String?
    
    /// account id
    public var accountId: String?
    
    /// visitor data
    public var visitorData: [String: Any]
    
    /// account data
    public var accountData: [String: Any]
    
    /// Initializes a session data
    /// - Parameters:
    ///   - visitorId: visitor id
    ///   - accountId: account id
    ///   - visitorData: visitor data
    ///   - accountData: account data
    public init(
        visitorId: String? = nil,
        accountId: String? = nil,
        visitorData: [String: Any] = [:],
        accountData: [String: Any] = [:]
    ) {
        self.visitorId = visitorId
        self.accountId = accountId
        self.visitorData = visitorData
        self.accountData = accountData
    }
}
