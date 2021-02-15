//
//  Role.swift
//  Stardust
//
//  Created by Masha Vodolazkaya on 15/02/2021.
//

import Foundation

struct Role: Codable, Mappable {
    
    var id: Snowflake
    var name: String
    
    /// integer representation of hexadecimal color code
    var color: Int
    
    /// if this role is pinned in the user listing
    var hoist: Bool
    
    var position: Int
    var permissions: Int
    var managed: Bool
    var mentionable: Bool
    
    var tags: RoleTags?
    
    struct RoleTags: Codable, Mappable {
        var botId: Snowflake?
        var integrationId: Snowflake?
        var premiumSubscriber: Bool?
    }
}
