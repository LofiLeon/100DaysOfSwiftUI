import Cocoa

// first wrong try
//func array (_:[Int]?) -> Int {return array?.randomElement() ?? return random(1...100)}
//var number = random.(1...100)
//print(number)
 
func getNumber (in array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}

var array = [33,324,434,3242]

print(getNumber(in: array))




