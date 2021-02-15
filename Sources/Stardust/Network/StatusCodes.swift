//
//  StatusCodes.swift
//  Stardust
//
//  Created by Masha Vodolazkaya on 14/02/2021.
//

import Foundation

enum GatewayCloseEventCode: Int, Codable {
    /**
    **Description**: Unknown error
    **Explanation**: We're not sure what went wrong. Try reconnecting?
     */
    case unknownError = 4000
    
    /**
    **Description**: Unknown opcode
    **Explanation**: You sent an invalid [Gateway opcode](https://discord.com/developers/docs/topics/gateway#payloads-and-opcodes) or an invalid payload for an opcode. Don't do that!
     */
    case unknownOpCode = 4001
    
    /**
    **Description**: Decode error
    **Explanation**: You sent an invalid [payload](https://discord.com/developers/docs/topics/gateway#sending-payloads) to us. Don't do that!
     */
    case decodeError = 4002
    
    /**
    **Description**: Not authenticated
    **Explanation**: You sent us a payload prior to [identifying](https://discord.com/developers/docs/topics/gateway#identify).
     */
    case notAuthenticated = 4003
    
    /**
    **Description**: Authentication failed
    **Explanation**: The account token sent with your [identify payload](https://discord.com/developers/docs/topics/gateway#identify) is incorrect.
     */
    case authenticationFailed = 4004
    
    /**
    **Description**: Already authenticated
    **Explanation**: You sent more than one identify payload. Don't do that!
     */
    case alreadyAuthenticated = 4005
    
    /**
    **Description**: Invalid `seq`
    **Explanation**: The sequence sent when [resuming](https://discord.com/developers/docs/topics/gateway#resume) the session was invalid. Reconnect and start a new session.
     */
    case invalidSequence = 4007
    
    /**
    **Description**: Rate limited
    **Explanation**: Woah nelly! You're sending payloads to us too quickly. Slow it down! You will be disconnected on receiving this.
     */
    case rateLimited = 4008
    
    /**
    **Description**: Session timed out
    **Explanation**: Your session timed out. Reconnect and start a new one.
     */
    case sessionTimedOut = 4009
    
    /**
    **Description**: Invalid shard
    **Explanation**: You sent us an invalid [shard when identifying](https://discord.com/developers/docs/topics/gateway#sharding).
     */
    case invalidShard = 4010
    
    /**
    **Description**: Sharding required
    **Explanation**: The session would have handled too many guilds - you are required to [shard](https://discord.com/developers/docs/topics/gateway#sharding) your connection in order to connect.
     */
    case shardingRequired = 4011
    
    /**
    **Description**: Invalid API version
    **Explanation**: You sent an invalid version for the gateway.
     */
    case invalidAPIVersion = 4012
    
    /**
    **Description**: Invalid intent(s)
    **Explanation**: You sent an invalid intent for a [Gateway Intent](https://discord.com/developers/docs/topics/gateway#gateway-intents). You may have incorrectly calculated the bitwise value.
     */
    case invalidIntent = 4013
    
    /**
    **Description**: Disallowed intent(s)
    **Explanation**: You sent a disallowed intent for a [Gateway Intent](https://discord.com/developers/docs/topics/gateway#gateway-intents). You may have tried to specify an intent that you [have not enabled or are not whitelisted for](https://discord.com/developers/docs/topics/gateway#privileged-intents).
     */
    case disallowedIntent = 4014
    
   
}
