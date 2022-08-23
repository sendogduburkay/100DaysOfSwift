import UIKit

func lengthOf(strings: [String]) -> [Int]{
    var result = [Int]()
    for string in strings {
        result.append(string.count)
    }
    return result
}

func lengtOfMap(_ string: [String]) -> [Int] {
    return string.map{ $0.count }
}


lengtOfMap(["Burkay","Gülten","Tulga","Asya","Onur"])
lengthOf(strings: ["Gülten","Tulga","Asya"])


var score = [2,3,4]
var formatted = score.map{
    "Your score is: \($0)"
}
print(formatted[0] , terminator: "")


let numbers = [4.0,9.0,16.0]
let result = numbers.map(sqrt)
print(result)

let input = ["1","5","Burkay"]
let numbers2 = input.compactMap{ Int($0) }
print(numbers2)



let filterNumbers = [1,2,3,4,5,6,7,8]
print(filterNumbers.filter{
    $0 % 2 == 0
})

/* Dizinin içinde en çok tekrar edeni buluyor.!!!*/

let ints = [1,5,9,5,6,6,6]
let counts = ints.map{ ($0,1)}
let dictionary = Dictionary(counts,uniquingKeysWith: +)

let array = Array(1...100)
let sum = array.reduce(0, +)

var result2 = 0
for i in 1...100{
    result2 += i
}
print(result2)


let yes = ["oui","ouais","bien sur"]
let reply = "ma reponse est oui"
yes.contains(where: reply.contains)
