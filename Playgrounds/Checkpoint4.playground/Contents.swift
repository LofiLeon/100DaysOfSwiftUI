import Cocoa

enum outOfBounce : Error {
    case tooLow
    case tooHigh
}

func squareRoot(_ number: Int) throws -> String {
    if number > 1000 {throw outOfBounce.tooHigh}
    if number < 1 {throw outOfBounce.tooLow}

    for i in 1...1000 {
        if i * i == number {
            return "is \(i)"
        }
    }
    return ("can not be found")
}
    
let number = 144

do {
    let result = try squareRoot(number)
    print("The Square root of \(number) \(result)")
} catch outOfBounce.tooLow {
    print("The number is too low!")
} catch outOfBounce.tooHigh {
    print("The number is too high!")
}
    
    
    
