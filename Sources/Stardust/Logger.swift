//
//  Logger.swift
//  swipe
//
//  Created by Masha Vodolazkaya on 01/05/2020.
//  Copyright © 2020 Paola Castro. All rights reserved.
//

import Foundation

class Logger {
    
    static var verbose: Int = 5
    
    class func setVerbose(value: Int) {
        verbose = value
    }
    
    class func error(_ message: String,
                     function: String = #function,
                     file: String = #file,
                     line: Int = #line) {
        
        let url = NSURL(fileURLWithPath: file)
        
        print("❌ Error: \"\(message)\" \n ↳(File: \(url.lastPathComponent ?? "?"), Function: \(function), Line: \(line)) \n")
    }
    class func log(_ message: String,
                   function: String = #function,
                   file: String = #file,
                   line: Int = #line) {
        
        let url = NSURL(fileURLWithPath: file)
        
        if verbose > 2 {
            print("LOG: \"\(message)\" \n ↳(File: \(url.lastPathComponent ?? "?"), Function: \(function), Line: \(line)) \n")
        }
    }
    class func logLowPriority(_ message: String,
                              function: String = #function,
                              file: String = #file,
                              line: Int = #line) {
        
        let url = NSURL(fileURLWithPath: file)
        
        if verbose > 4 {
            print("LOG: \"\(message)\" \n ↳(File: \(url.lastPathComponent ?? "?"), Function: \(function), Line: \(line)) \n")
        }
    }
    
    class func logHighPriority(_ message: String,
                               function: String = #function,
                               file: String = #file,
                               line: Int = #line) {
        
        let url = NSURL(fileURLWithPath: file)
        
        if verbose > 0 {
            print("LOG: \"\(message)\" \n ↳(File: \(url.lastPathComponent ?? "?"), Function: \(function), Line: \(line)) \n")
        }
    }
    
    class func logDecodingError(_ jsonDict: [String: Any],
                                error: DecodingError,
                                function: String = #function,
                                file: String = #file,
                                line: Int = #line) {
        let message: String
        switch error {
        case .typeMismatch(let type, let context):
            message = decodingErrorMessage("TYPE_MISMATCH: \(type)",
                                           jsonDict: jsonDict,
                                           context: context,
                                           description: error.localizedDescription)
        case .valueNotFound(let type, let context):
            message = decodingErrorMessage("VALUE_NOT_FOUND: \(type)",
                                           jsonDict: jsonDict,
                                           context: context,
                                           description: error.localizedDescription)
        case .keyNotFound(let key, let context):
            message = decodingErrorMessage("KEY_NOT_FOUND: \(key.stringValue)",
                                           jsonDict: jsonDict,
                                           context: context,
                                           description: error.localizedDescription)
        case .dataCorrupted(let context):
            message = decodingErrorMessage("DATA_CORRUPTED:",
                                           jsonDict: jsonDict,
                                           context: context,
                                           description: error.localizedDescription)
        default:
            message = error.localizedDescription
        }
        let url = NSURL(fileURLWithPath: file)
        print("❌ Decoding error: \(message) \n ↳(File: \(url.lastPathComponent ?? "?"), Function: \(function), Line: \(line)) \n")
    }
    
    private class func decodingErrorMessage(_ errorType: String,
                                            jsonDict: [String: Any],
                                            context: DecodingError.Context,
                                            description: String) -> String {
        let path = context.codingPath.reduce(into: "", { $0.append("/" + $1.stringValue) })
        let key = context.codingPath.last?.stringValue ?? ""
        let value = jsonDict[key]
        let message = "\n\(errorType) \nPATH: \(path) \nFAILED VALUE: \(value ?? "<>") \nCONTEXT: \(context.debugDescription) \nERROR: \(description)"
        
        return message
    }
}
