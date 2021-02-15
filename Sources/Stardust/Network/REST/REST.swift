//
//  REST.swift
//  
//
//  Created by Masha Vodolazkaya on 09/02/2021.
//

import Foundation

extension URLRequest {
    
    static func multipartDataRequest(url: URL, data: Data, fieldName: String, fileName: String, mimeType: String, params: [String: String] = [:]) -> URLRequest {
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                
        let httpBody = NSMutableData()

        for (key, value) in params {
          httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
        }

        let convertedData = convertFileData(fieldName: fieldName,
                                            fileName: fileName,
                                            mimeType: mimeType,
                                            fileData: data,
                                            using: boundary)
        httpBody.append(convertedData)

        httpBody.appendString("--\(boundary)--")

        request.httpBody = httpBody as Data
        
        return request
    }
    
    private static func convertFormField(named name: String, value: String, using boundary: String) -> String {
      var fieldString = "--\(boundary)\r\n"
      fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
      fieldString += "\r\n"
      fieldString += "\(value)\r\n"
      return fieldString
    }
    
    private static func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
      let data = NSMutableData()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")

      return data as Data
    }
}

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
