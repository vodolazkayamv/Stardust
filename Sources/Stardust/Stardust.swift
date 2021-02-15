open class Stardust {
    var text = "Hello, World!"
    
    var token: String
    
    public init(token: String) {
        self.token = token
        let bot = Bot(token: token)
        bot.connect()
        while true {
            
        }
    }
}
