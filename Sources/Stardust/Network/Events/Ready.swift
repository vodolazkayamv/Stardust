//
//  Ready.swift
//  Stardust
//
//  Created by Masha Vodolazkaya on 15/02/2021.
//

import Foundation

struct Ready: Codable, Mappable {
    var version: Int
    var user: User
    var privateChannels: JSON
    var guilds: [Guild.UnavailableGuild]
    var sessionId: String
    var shard: [Int]?
    var application: Application
    
    
    enum CodingKeys: String, CodingKey {
        case version = "v"
        case user = "user"
        case privateChannels = "private_channels"
        case guilds = "guilds"

        case sessionId = "session_id"

        case shard = "shard"
        
        case application = "application"
    }
}
