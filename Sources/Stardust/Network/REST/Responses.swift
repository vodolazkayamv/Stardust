//
//  Responses.swift
//  
//
//  Created by Masha Vodolazkaya on 11/02/2021.
//

import Foundation

struct SessionProperties: Mappable {
    var maximumConcurrency: Int
    var remainingConcurrencies: Int
    var resetingAfter: Int
    var total: Int
    
    enum CodingKeys: String, CodingKey {
        case maximumConcurrency = "max_concurrency"
        case remainingConcurrencies = "remaining"
        case resetingAfter = "reset_after"
        case total = "total"
    }
}

struct GetGatewayResponse: Mappable {
    var gatewayUrl: String
    var sessionStartLimit: SessionProperties
    var shards: Int
    
    enum CodingKeys: String, CodingKey {
        case gatewayUrl = "url"
        case sessionStartLimit = "session_start_limit"
        case shards = "shards"
    }
}
