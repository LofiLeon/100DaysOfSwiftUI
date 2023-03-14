import Cocoa

struct Car {
    let model: String
    let noOfSeats: Int
    private static var currentGear: Int = 0
    
    init(model: String, noOfSeats: Int, currentGear: Int){
        self.model = model
        self.noOfSeats = noOfSeats
        Car.currentGear = currentGear
    }
    
    static func increaseGear(){
        if self.currentGear + 1 <= 10 {
            currentGear += 1
            print("You are now driving in gear \(currentGear)")
        } else {
            print("You are already in the highest gear!")
        }
    }
    
    static func decreaseGear(){
        if self.currentGear - 1 >= 0 {
            currentGear -= 1
            print("You are now driving in gear \(currentGear)")
        } else {
            print("You are already in the lowest gear!")
        }
    }
}



