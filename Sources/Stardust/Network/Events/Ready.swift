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
    
    /**
     When connecting to the gateway as a bot user, guilds that the bot is a part of will start out as unavailable. Don't fret! The gateway will automatically attempt to reconnect on your behalf.
     
     As guilds become available to you, you will receive `Guild Create` events.
     */
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
