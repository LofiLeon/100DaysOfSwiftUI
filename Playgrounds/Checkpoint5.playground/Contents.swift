import Cocoa

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let result = luckyNumbers.filter {$0.isMultiple(of: 2) == false}.sorted().map {"\($0) is a lucky number!"}

for i in result {
    print(i)
}

print()

let result2: () = luckyNumbers.filter {$0.isMultiple(of: 2) == false}.sorted().map {"\($0) is a lucky number!"}.forEach{print($0)}

print()

//result 3

func isOdd(number: Int) -> Bool {
    number.isMultiple(of: 2) == false
}

func luckyString(number: Int) -> String {
    "\(number) is a lucky number!"
}

func printValue(string: String) {
    print(string)
}

luckyNumbers.filter(isOdd).sorted().map(luckyString).forEach(printValue)





