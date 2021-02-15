//
//  Mappable.swift
//  
//
//  Created by Masha Vodolazkaya on 11/02/2021.
//

import Foundation

protocol Mappable: Decodable {
    init?(jsonDict: [String: Any],
          function: String,
          file: String,
          line: Int)
}

extension Mappable {
    
    init?(jsonDict: [String: Any],
          function: String = #function,
          file: String = #file,
          line: Int = #line) {
        guard let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else {
            Logger.error("ERROR: Services: failed to serialise jsonDict: '\(jsonDict)' into data while decoding '\(String(describing: Self.self))'.",
                         function: function, file: file, line: line)
            return nil
        }
        do {
            let decodedData = try JSONDecoder().decode(Self.self, from: data)
            self = decodedData
        } catch let error as DecodingError {
            Logger.logDecodingError(jsonDict, error: error, function: function, file: file, line: line)
            return nil
        } catch {
            Logger.error("ERROR: Services: failed decoding '\(String(describing: Self.self))' from data.",
                         function: function, file: file, line: line)
            return nil
        }
    }
}
