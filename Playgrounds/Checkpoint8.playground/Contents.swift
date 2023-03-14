import Cocoa

protocol Building {
    var type : String {get}
    var rooms : Int {get}
    var cost : Int {get set}
    var agent : String {get set}
    
    func summary()
}

extension Building {
    func summary () {
        print("Contact \(agent) to buy this \(type) for \(cost)€")
    }
}

struct House: Building {
    let type = "house"
    var rooms: Int
    var cost: Int
    var agent: String
}


struct Office: Building {
    let type = "office"
    var rooms: Int
    var cost: Int
    var agent: String
}

let exampleOffice = Office(rooms: 2, cost: 2500, agent: "MindSpace")
exampleOffice.summary()

let exampleHouse = House(rooms: 2, cost: 2500, agent: "MindSpace")
exampleHouse.summary()
