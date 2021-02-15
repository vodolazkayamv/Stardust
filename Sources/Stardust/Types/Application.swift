//
//  Application.swift
//  Stardust
//
//  Created by Masha Vodolazkaya on 15/02/2021.
//

import Foundation

///https://discord.com/developers/docs/topics/oauth2#application-object
struct Application: Codable, Mappable {
    var id: Snowflake
    var name: String?
    var icon: String?
    var description: String?
    var rpcOrigins: [String]?
    var botPublic: Bool?
    var botRequireCodeGrant: Bool?
    var owner: User?
    var summary: String?
    var verifyKey: String?
    
    // var team: Team
    
    var guildId: Snowflake?
    var primarySKUId: Snowflake?
    
    var slug: String?
    var coverImage: String?
    var flags: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case icon = "icon"
        case rpcOrigins = "rpc_origins"
        case botPublic = "bot_public"
        case botRequireCodeGrant = "bot_require_code_grant"
        case description = "description"
        case owner = "owner"
        case summary = "summary"
        case verifyKey = "verify_key"
        // case team = "team"
        case guildId = "guild_id"
        case primarySKUId = "primary_sku_id"
        case slug = "slug"
        case coverImage = "cover_image"
        case flags = "flags"
    }
}
