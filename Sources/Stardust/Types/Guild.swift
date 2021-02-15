//
//  Guild.swift
//  
//
//  Created by Masha Vodolazkaya on 15/02/2021.
//

import Foundation

struct Guild: Codable, Mappable {
    
    var id: Snowflake
    var name: String?
    var icon: String?
    var splash: String?
    var discoverySplash: String?
    var emojis: JSON
    var features: JSON
    var approximateMemberCount: Int
    var approximatePresenceCount: Int
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
        case splash = "splash"
        case discoverySplash = "discovery_splash"
        case emojis = "emojis"
        case features = "features"
        case approximateMemberCount = "approximate_member_count"
        case approximatePresenceCount = "approximate_presence_count"
        case description = "description"
    }
    
    struct UnavailableGuild: Codable, Mappable {
        var id: Snowflake
        var unavailable: Bool
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case unavailable = "unavailable"
        }
        
    }
    
}
