//
//  Payload.swift
//  
//
//  Created by Masha Vodolazkaya on 14/02/2021.
//

import Foundation

struct Payload: Codable, Mappable {
    var opcode: GatewayOpCode
    var data: JSON
    var sequence: Int? = nil
    var event: Event? = nil
     
    enum CodingKeys: String, CodingKey {
        case opcode = "op"
        case data = "d"
        case sequence = "s"
        case event = "t"
    }
    
    /**
     # Identify Structure
 
     IDENTIFY supports additional optional fields for other session properties, such as payload compression, or an initial presence state. See the [Identify Structure](https://discord.com/developers/docs/topics/gateway#identify) for a more complete example of all options you can pass in.
     
     This is a minimal IDENTIFY payload:
        ```
     {
       "op": 2,
       "d": {
         "token": "my_token",
         "intents": 513,
         "properties": {
           "$os": "linux",
           "$browser": "my_library",
           "$device": "my_library"
         }
       }
     }
     ```
     */
    struct Identify: Codable, Mappable {
        /// authentication token
        var token: String
        
        /// [connection properties](https://discord.com/developers/docs/topics/gateway#identify-identify-connection-properties)
        var properties: Properties
        
        /// whether this connection supports compression of packets
        var compress: Bool? = false

        /// value between 50 and 250, total number of members where the gateway will stop sending offline members in the guild member list
        var largeTheshold: Int = 50
        
        /// used for [Guild Sharding](https://discord.com/developers/docs/topics/gateway#sharding)
        var shard: [Int]?
        
        /// presence structure for initial presence information
        var presence: Status?
        
        /// enables dispatching of guild subscription events (presence and typing events)
        var guildSubscriptions: Bool? = true
        
        /// the [Gateway Intents](https://discord.com/developers/docs/topics/gateway#gateway-intents) you wish to receive
        var intents: Int
        
        /// Identify Connection Properties 
        struct Properties: Codable, Mappable {
            var os: String
            var browser: String
            var device: String
            
            enum CodingKeys: String, CodingKey {
                case os = "$os"
                case browser = "$browser"
                case device = "$device"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case largeTheshold = "large_threshold"
            case guildSubscriptions = "guild_subscriptions"
            case intents = "intents"
            case token = "token"
            case properties = "properties"
        }
    }
    
    enum Status: String, Codable {
        case online
        case dnd
        case idle
        case invisible
        case offline
    }
    
    
    /**
        All gateway events in Discord are tagged with an opcode that denotes the payload type. Your connection to Discord gateway may also sometimes close. When it does, you will receive a close code that tells you what happened.

         This enum is desripring those opcodes.
         */
    enum GatewayOpCode: Int, Codable {
        
        /**
        # Name
         Dispatch
         
        # Client Action
         Recieve
         
        # Description
         An event was dispatched.
         */
        case dispatch = 0
        
        /**
        # Name
         Heartbeat
         
        # Client Action
         Send/Receive
         
        # Description
         Fired periodically by the client to keep the connection alive.
         */
        case heartbeat = 1
        
        /**
        # Name
         Identify
         
        # Client Action
         Send
         
        # Description
         Starts a new session during the initial handshake.
         */
        case identify = 2
        
        /**
        # Name
         Presence Update
         
        # Client Action
         Send
         
        # Description
         Update the client's presence.
         */
        case presenceUpdate = 3
        
        /**
        # Name
         Voice State Update
         
        # Client Action
         Send
         
        # Description
         Used to join/leave or move between voice channels.
         */
        case voiceStateUpdate = 4
        
        /**
        # Name
         Resume
         
        # Client Action
         Send
         
        # Description
         Resume a previous session that was disconnected.
         */
        case resume = 6
        
        /**
        # Name
         Reconnect
         
        # Client Action
         Recieve
         
        # Description
         You should attempt to reconnect and resume immediately.
         */
        case reconnect = 7
        
        /**
        # Name
         Request Guild Members
         
        # Client Action
         Send
         
        # Description
         Request information about offline guild members in a large guild.
         */
        case requestGuildMembers = 8
        
        /**
        # Name
         Invalid Session
         
        # Client Action
         Recieve
         
        # Description
         The session has been invalidated. You should reconnect and identify/resume accordingly.
         */
        case invalidSession = 9
        
        /**
        # Name
         Hello
         
        # Client Action
         Recieve
         
        # Description
         Sent immediately after connecting, contains the `heartbeat_interval` to use.
         
         The client should now begin sending Opcode 1 Heartbeat payloads every `heartbeat_interval` milliseconds, until the connection is eventually closed or terminated. This OP code is also bidirectional. The gateway may request a heartbeat from you in some situations, and you should send a heartbeat back to the gateway as you normally would.
         */
        case hello = 10
        
        /**
        # Name
         Heartbeat ACK
         
        # Client Action
         Recieve
         
        # Description
         Sent in response to receiving a heartbeat to acknowledge that it has been received.
         */
        case heartbeatACK = 11
    }

    enum Event: String, Codable {
        // https://github.com/discordjs/discord.js/blob/master/src/util/Constants.js

        case ready = "READY"
        case rateLimit = "RATE_LIMIT"

        
        case raw = "RAW"
        case invalidated = "INVALIDATED"

        case guildCreate = "GUILD_CREATE"
        case guildUpdate = "GUILD_UPDATE"
        case guildDelete = "GUILD_DELETE"
        case guildUnavailable = "GUILD_UNAVAILABLE"
        case guildAvailable = "GUILD_AVAILABLE"

        case guildMembersChunk = "GUILD_MEMBERS_CHUNK"
        case guildMemberSpeaking = "GUILD_MEMBER_SPEAKING"
        case guildMemberAvailable = "GUILD_MEMBER_AVAILABLE"
        case guildMemberUpdate = "GUILD_MEMBER_UPDATE"
        case guildMemberAdd = "GUILD_MEMBER_ADD"
        case guildMemberRemove = "GUILD_MEMBER_REMOVE"

        case guildRoleCreate = "GUILD_ROLE_CREATE"
        case guildRoleDelete = "GUILD_ROLE_DELETE"
        case guildRoleUpdate = "GUILD_ROLE_UPDATE"

        case guildIntegrationsUpdate = "GUILD_INTEGRATIONS_UPDATE"

        case guildEmojiCreate = "GUILD_EMOJI_CREATE"
        case guildEmojiDelete = "GUILD_EMOJI_DELETE"
        case guildEmojiUpdate = "GUILD_EMOJI_UPDATE"

        case guildBanRemove = "GUILD_BAN_REMOVE"
        case guildBanAdd = "GUILD_BAN_ADD"

        case inviteDelete = "INVITE_DELETE"
        case inviteCreate = "INVITE_CREATE"

        case channelCreate = "CHANNEL_CREATE"
        case channelUpdate = "CHANNEL_UPDATE"
        case channelDelete = "CHANNEL_DELETE"
        case channelPinsUpdate = "CHANNEL_PINS_UPDATE"


        case shardReady = "SHARD_READY"
        case shardReconnecting = "SHARD_RECONNECTING"
        case shardError = "SHARD_ERROR"
        case shardResume = "SHARD_RESUME"
        case shardDisconnect = "SHARD_DISCONNECT"

        case debug = "DEBUG"
        case warn = "WARN"
        case error = "ERROR"

        case voiceStateUpdate = "VOICE_STATE_UPDATE"
        case voiceServerUpdate = "VOICE_SERVER_UPDATE"
        case voiceBroadcastSubscribe = "VOICE_BROADCAST_SUBSCRIBE"
        case voiceBroadcastUnsubscribe = "VOICE_BROADCAST_UNSUBSCRIBE"

        case typingStop = "TYPING_STOP"
        case typingStart = "TYPING_START"

        case webhookUpdate = "WEBHOOK_UPDATE"

        case presenceUpdate = "PRESENCE_UPDATE"
        case userUpdate = "USER_UPDATE"

        case messageUpdate = "MESSAGE_UPDATE"
        case messageDelete = "MESSAGE_DELETE"
        case messageCreate = "MESSAGE_CREATE"

        case messageBulkDelete = "MESSAGE_BULK_DELETE"
        
        case messageReactionAdd = "MESSAGE_REACTION_ADD"
        case messageReactionRemoveEmoji = "MESSAGE_REACTION_REMOVE_EMOJI"
        case messageReactionRemove = "MESSAGE_REACTION_REMOVE"
        case messageReactionRemoveAll = "MESSAGE_REACTION_REMOVE_ALL"
    }
}
