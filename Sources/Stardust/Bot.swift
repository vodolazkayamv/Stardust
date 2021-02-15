//
//  File.swift
//  
//
//  Created by Masha Vodolazkaya on 10/02/2021.
//

import Foundation
import Alamofire
import Dispatch
import Starscream

class Bot {
    var token: String
    var gatewayUrl: String = ""
    var socket: WebSocket?
    
    var isConnected: Bool = false
    var isIdentified: Bool = false
    
    var heartbeater: Timer?
    let encoder = JSONEncoder()
    
    public init(token:String) {
        self.token = token
    }
    
    public func connect() {
        self.getGateway()
        RunLoop.main.run()
    }
    
    func getGateway() {
        let headers: HTTPHeaders = [HTTPHeader.authorization("Bot \(token)")]
        
        let request = AF.request(Endpoints.gatewayBot.url,
                                 method: Endpoints.gatewayBot.method,
                                 headers: headers)
        request.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any],
                      let resp = GetGatewayResponse(jsonDict: json) else {
                    Logger.error("failed to parse GetGateway response")
                    return
                }
                self.gatewayUrl = resp.gatewayUrl
                
                self.connectSocket()
            case .failure(_):
                Logger.error("failed to GetGateway")
                break
            }
            
        }
    }
    
    func connectSocket() {
        var request = URLRequest(url: URL(string: gatewayUrl)!)
        request.timeoutInterval = 5
        self.socket = WebSocket(request: request)
        guard let socket = self.socket else {
            return
        }
        socket.delegate = self
        socket.connect()
    }
}

extension Bot: WebSocketDelegate {
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            Logger.logLowPriority("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            Logger.logLowPriority("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            Logger.logLowPriority("Received text: \(string)")
            handleRecievedText(text: string)
        case .binary(let data):
            Logger.logLowPriority("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        
    }
    
    
}


extension Bot {
    func heartbeat() {
        let payload = Payload(opcode: .heartbeat, data: nil)
        do {
            let jsonPayload = try encoder.encode(payload)
            socket?.write(data: jsonPayload, completion: {
                Logger.logLowPriority("heartbeat sent")
            })
        }
        catch {
            Logger.error("failed to encode hearbeat")
        }
        
        
    }
    
    func identify() {
        do {
            let identify = Payload.Identify(token: token,
                                            properties: Payload.Identify.Properties(
                                                os: "linux",
                                                browser: "my_library",
                                                device: "my_library"),
                                            intents: 513)
            let payload = try Payload(opcode: .identify, data: JSON(encodable: identify))
            let jsonPayload = try encoder.encode(payload)
            socket?.write(data: jsonPayload, completion: {
                print("hearbeat sent")
            })
        }
        catch let error {
            Logger.error("failed to encode identify: \(error)")
        }
    }
    
    func handleRecievedText(text: String)  {
        guard let data = text.data(using: .utf16),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let jsonDict = jsonData as? [String: Any] else {
            return
        }
        
        guard let response = Payload(jsonDict: jsonDict) else {
            return
        }
        
        switch response.opcode {
        case .hello:
            guard let recievedHeartbeatInterval = response.data["heartbeat_interval"]?.doubleValue else {
                Logger.error("failed to decode hearbeat interval")
                return
            }
            // recievedHeartbeatInterval is in milliseconds
            let heartbeatInterval = TimeInterval(recievedHeartbeatInterval/1000)
            heartbeater = Timer.scheduledTimer(withTimeInterval: heartbeatInterval,
                                               repeats: true) { [weak self] _ in
                self?.heartbeat()
            }
            
            if !isIdentified {
                identify()
            }
            
            break
        case .heartbeatACK:
            Logger.logLowPriority("hearbeat received and acknowledged")
            
        case .dispatch:
            Logger.logLowPriority("an event has dispatched!")
            
            switch response.event {
            case .ready:
                ready(payload: response)
                break
            case .guildCreate:
                
                break
            default:
                break
                
            }
            break
        default:
            Logger.log("Received text: \(text)")
            break
        }
    }
    
    func ready(payload: Payload) {
        do {
            let data = try JSONEncoder().encode(payload.data)
            guard let jsonData = try? JSONSerialization.jsonObject(with: data),
                  let jsonDict = jsonData as? [String: Any] else {
                return
            }
           
            let ready = Ready(jsonDict:jsonDict)
            print (ready)
        } catch let error {
            Logger.log(error.localizedDescription)
        }
    }
}
