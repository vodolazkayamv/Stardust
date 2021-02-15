//
//  File.swift
//  
//
//  Created by Masha Vodolazkaya on 09/02/2021.
//

import Foundation
import Alamofire

struct Endpoints {
    
    static var gatewayBot = Endpoint(suffix: "/gateway/bot", method: .get)
}

struct Endpoint {
    internal let baseAddress = "https://discord.com/api/v8/"
    
    var suffix: String
    
    var url: String {
        return baseAddress + suffix
    }
    
    var method: Alamofire.HTTPMethod
    
}
