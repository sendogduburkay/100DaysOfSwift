import UIKit

let colors = Set(["red","red","blue","blue","black"])

print(colors.sorted())

var name = (first:"Taylor",second:"Swift")
name.0
name.first
name.second


let tuple = (name:"Burkay",lastname:"Şendoğdu",address:"555") /* Eğer belirli bir veri setini tutmak istiyorsak ve yazıldığı gibi kalmasını istiyorsak.*/

let set = Set(["doktor","hakim","savcı"]) /* Eğer hızlı bir sorgulama ve unique değerler istiyorsak Set kullanacağız.*/

let array = ["elma","armut","karpuz"] /* Yinelenen nesneler veya nesnelerin sıralamasının önemli olduğu zamanlarda arraylar kullanırız*/

//------------------------------------------------ CREATE A DICTIONARY, SEARCH AND ADD ITEMS
var favoriteIceCream = [
    "Paul" : "Chocolate",
    "Burkay" : "Melon"
]
favoriteIceCream["Burkay"]
favoriteIceCream["Gülten", default: "Vanilla"]
favoriteIceCream["Gülten"] = "Banana"
favoriteIceCream["Gülten"]
//------------------------------------------------ CREATE A DICTIONARY AND ADD AN ITEM
var teams = [String:String]()
teams["Paul"] = "Red"
//------------------------------------------------ CREATE SET AND INSERT AN ITEM
var words = Set<String>()
words.insert("a")
words.insert("b")

print(words)

//------------------------------------------------ ENUMS
enum Result{
    case failure
    case success
}

let result4 = Result.failure
print(result4)
//------------------------------------------------ USING ENUMS DESCRIPTIONS

enum Activities{
    case boring
    case running(destination : String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activities.talking(topic: "Football")
let singing = Activities.singing(volume: 5)
//------------------------------------------------ USING ENUM WITH INT

enum Planet: Int{ /*Eğer mercury'e 1 verirsen 2 olarak venusu alacak. Bu şekilde integerlar ile değer atamaası yapmak istiyor isek Intten inheritance(miras) almak gerekiyor. */
    case mercury = 1
    case venus
    case earth
    case mars
}
let earth = Planet(rawValue: 2)!
print(earth)
//------------------------------------------------ SHORT IF ELSE STATEMENT
let firstCard = 11
let secondCard = 11
print(firstCard == secondCard ? "Same cards" : "Different cards")

//------------------------------------------------ SWITCH CASE STATEMENTS
let weather = "sunny"
switch weather{
case "rain":print("Bring an umbrella")
case "snow":print("Wrap Up warm")
case "sunny":print("Wear sunscreen")
    fallthrough
default : print("Enjoy your day!")
}
//------------------------------------------------ LOOP
print("player gonna")
for _ in 1...5{
    print("play")
}
//------------------------------------------------ REPEAT WHILE LOOP
var number = 1
repeat {
    print(number)
    number += 1
} while number <= 20
//------------------------------------------------ EXITING LOOPS
var countDown = 10
while countDown >= 0{
    print(countDown)
    if countDown == 4{
        print("I'm bored, let's go now!")
        break
    }
    countDown -= 1
}

//------------------------------------------------ NESTED LOOPS
for i in 1...10{
    for j in 1...10{
        let product = i * j
        print("\(i) * \(j) = \(product)")
    }
}
//------------------------------------------------ EXITING MULTIPLE LOOPS Aşağıdaki outerLoop'un çalışabilmesi için loop başına onu label olarak tanımlamak gerekiyor.
outerLoop : for i in 1...10{
    for j in 1...10{
        let product = i * j
        print("\(i) * \(j) = \(product)")
        if product == 50{
            print("It's bullseye!")
            break outerLoop
        }
    }
}
//------------------------------------------------ SKIPPING ITEMS IN A LOOP
for i in 1...10{
    if i % 2 == 0{
        continue
    }
    print(i)
}
//------------------------------------------------ INFINITE LOOPS
var counter = 1
while true{
    counter+=1
    if counter == 250{
        break
    }
    print(counter)
}

//------------------------------------------------ FUNCTIONS
func square(number:Int) -> Int{
    return number*number
}

var result = square(number: 9)
print(result)
//------------------------------------------------ VARIADIC FUNCTIONS
func square2(numbers : Int...){
    for number in numbers{
        print("\(number) squared is \(number * number)")
    }
}

square2(numbers: 1,2,3,4,5)

//------------------------------------------------ WRITING THROWING FUNCTIONS

enum passwordError : Error{
    case obvious
}
func checkPassword(_ password : String) throws -> Bool{
    if password == "password"{
        throw passwordError.obvious
        
    }
    return true
}

do{
    try checkPassword("password")
    print("This password is good!")
}
catch{
    print("You can't use that password!")
}

//------------------------------------------------  INOUT FUNCTIONS
func doubleInPlace(number: inout Int){
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)
print(myNum)

func square222(number: inout Int){
    number *= number
}

var nu = 16
square222(number: &nu)
print(nu)

//------------------------------------------------   CLOSURES

let driving = {
    print("I'm driving in my car")
}

let drivingToWhere = { (place:String) in
    print("I'm going to \(place) in my car ")
}
drivingToWhere("London")

func travel(action : () -> Void){ /*Void ile şunu diyoruz. Hiçbir parametre kabul edilmeyecek. Swiftin hiçbir şey deme şekli. */
    print("I'm getting ready to go.")
    action()
    print("I'm arrived!")
}

travel(action: driving)
