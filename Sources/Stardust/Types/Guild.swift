//
//  Guild.swift
//  
//
//  Created by Masha Vodolazkaya on 15/02/2021.
//

import Foundation

struct Guild: Codable, Mappable {
    
    // MARK: - Guild Preview
    var id: Snowflake
    var name: String?
    var icon: String?
    var splash: String?
    var discoverySplash: String?
    
    var emojis: JSON?
    var features: [String]?
    
    var approximateMemberCount: Int?
    var approximatePresenceCount: Int?
    var description: String?
    
    // MARK: - GUILD CREATE
    var joinedAt: TimeInterval?
    var large: Bool?
    var unavailable: Bool?
    var memberCount: Int?
    
    var voiceStates: JSON?
    var members: JSON?
    var channels: JSON?
    var presences: JSON?
    
    // MARK: - OTHER DETAILS
    
    var iconHash: String?
    var region: String?
    
    var afkChannelId: Snowflake?
    var afkTimeout: Int?
    var widgetEnabled: Bool?
    var widgetChannelId: Snowflake?
    var verificationLevel: Int?
    var defaultMessageNotifications: Int?
    var explicitContentFilter: Int?
    
    var roles: [Role]?
    
    var mfaLevel: Int?
    
    /// application id of the guild creator if it is bot-created
    var applicationId: Snowflake?
    var systemChannelId: Snowflake?
    var systemChannelFlags: Int?
    var rulesChannelId: Snowflake?
    
    var maxPresences: Int?
    var maxMembers: Int?
    var vamityUrlCode: String?
    var premiumTire: Int?
    var premiumSubscriptionCount: Int?
    var preferredLocale: String?
    var publicUpdatesChannel: Snowflake?
    var maxVideoChannelUsers: Int?
    
    var welcomeScreen: JSON?
    
    
    // MARK: - GET Current User Guilds
    
    /// true if the user is the owner of the guild
    var owner: Bool?
    var permissions: String?
    
    
    struct UnavailableGuild: Codable, Mappable {
        var id: Snowflake
        var unavailable: Bool
    }
    
}
