import XCTest
@testable import Stardust

import Alamofire

final class StardustTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Stardust().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
    
    func testAuth() {
        let e = expectation(description: "Alamofire")

        let token = "<bot token>"
        let headers: HTTPHeaders = [HTTPHeader.authorization("Bot \(token)")]
        
        let request = AF.request(Endpoints.gatewayBot.url,
                                 method: Endpoints.gatewayBot.method,
                   headers: headers)
        request.responseJSON { (response) in
            print(response)
            
            guard let json = response.value as? [String: Any] else {
                XCTFail()
                return
            }
            guard let resp = GetGatewayResponse(jsonDict: json) else {
                XCTFail()
                return
            }
            print(resp)
            e.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testBot() {
        let token = "ODA4MDMxODc4Njk4NzYyMjcw.YCAoVA.99-8XVQ5yIw1dxmXDg0HYnaSa8s"

        let e = expectation(description: "Alamofire")

        let bot = Bot(token: token)
        bot.connect()
        waitForExpectations(timeout: 15.0, handler: nil)

    }
}
