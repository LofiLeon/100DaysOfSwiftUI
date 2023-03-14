import Cocoa

//FizzBuzz game

let numbers = Array(1...1000000)

for i in numbers {
    
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FIZZBUZZ")
    } else if i.isMultiple(of: 3) {
        print("FIZZ")
    } else if i.isMultiple(of: 5)  {
        print("BUZZ")
    } else {
        print(i)
    }
}
