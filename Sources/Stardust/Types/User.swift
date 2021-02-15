//
//  User.swift
//  
//
//  Created by Masha Vodolazkaya on 15/02/2021.
//

import Foundation

/**
 [User Object](https://discord.com/developers/docs/resources/user#user-object)
 
 Users in Discord are generally considered the base entity. Users can spawn across the entire platform, be members of guilds, participate in text and voice chat, and much more.
 
 Users are separated by a distinction of "bot" vs "normal." Although they are similar, bot users are automated users that are "owned" by another user. Unlike normal users, bot users do *not* have a limitation on the number of Guilds they can be a part of.
 
  **Example User** :
 ```
 {
   "id": "80351110224678912",
   "username": "Nelly",
   "discriminator": "1337",
   "avatar": "8342729096ea3675442027381ff50dfe",
   "verified": true,
   "email": "nelly@discord.com",
   "flags": 64,
   "premium_type": 1,
   "public_flags": 64
 }
 ```
 */
struct User: Codable, Mappable {

    /**
    The user's id

    **Required OAUTH2 Scope**: identify
    */
    private var id: Snowflake
    
    /**
     The user's username, not unique across the platform
     
     Discord enforces the following restrictions for usernames and nicknames:
     
     1. Names can contain most valid unicode characters. We limit some zero-width and non-rendering characters.
     1. Usernames must be between 2 and 32 characters long.
     1. Nicknames must be between 1 and 32 characters long.
     1. Names are sanitized and trimmed of leading, trailing, and excessive internal whitespace.
     
     The following restrictions are additionally enforced for usernames:
     1. Names cannot contain the following substrings: `@`, `#`, `:`, ` ``` `
     1. Names cannot be: `discordtag`, `everyone`, `here`.
     
     There are other rules and restrictions not shared here for the sake of spam and abuse mitigation, but the majority of users won't encounter them.
     
     *It's important to properly handle all error messages returned by Discord when editing or updating names.*

    **Required OAUTH2 Scope**: identify
    */
    var username: String?
    
    /**
     The user's 4-digit discord-tag

    **Required OAUTH2 Scope**: identify
    */
    var discriminator: String?
    
    /**
     the user's avatar hash

    **Required OAUTH2 Scope**: identify
    */
    var avatar: String?
    
    /**
     whether the user belongs to an OAuth2 application

    **Required OAUTH2 Scope**: identify
    */
    var bot: Bool?
    
    /**
     whether the user is an Official Discord System user (part of the urgent message system)

    **Required OAUTH2 Scope**: identify
    */
    var system: Bool?
    
    /**
     whether the user has two factor enabled on their account

    **Required OAUTH2 Scope**: identify
    */
    var mfaEnabled: Bool?
    
    /**
     the user's chosen language option

    **Required OAUTH2 Scope**: identify
    */
    var locale: String?
    
    /**
     whether the email on this account has been verified

    **Required OAUTH2 Scope**: identify
    */
    var verified: Bool?
    
    /**
     the user's email

    **Required OAUTH2 Scope**: identify
    */
    var email: String?
    
    /**
     the [flags](https://discord.com/developers/docs/resources/user#user-object-user-flags) on a user's account

    **Required OAUTH2 Scope**: identify
    */
    var flags: Int?
    
    /**
     the type of [Nitro subscription](https://discord.com/developers/docs/resources/user#user-object-premium-types) on a user's account

    **Required OAUTH2 Scope**: identify
    */
    var premiumType: Int?
    
    /**
     the public [flags](https://discord.com/developers/docs/resources/user#user-object-user-flags) on a user's account

    **Required OAUTH2 Scope**: identify
    */
    var publicFlags: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case discriminator = "discriminator"
        case avatar = "avatar"
        case bot = "bot"
        case system = "system"
        case mfaEnabled = "mfa_enabled"
        case locale = "locale"
        case verified = "verified"
        case email = "email"
        case flags = "flags"
        case premiumType = "premium_type"
        case publicFlags = "public_flags"
    }
    
    
}
