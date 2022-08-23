import UIKit

//--------------------------------- PROTOCOLS //---------------------------------

protocol Identifiable{
    var id : String { get set}
}

struct User : Identifiable{
    var id: String
}

func displayID(thing : Identifiable){
    print("my identifier is \(thing.id)")
}


var deneme = User(id: "123123")
print(displayID(thing: deneme))

//---------------------------------

protocol Purchaseable{
    var name : String {get set}
}

struct Book: Purchaseable {
    var name: String
    var author: String
}

struct Movie: Purchaseable {
    var name: String
    var actors: [String]
}

struct Car: Purchaseable {
    var name: String
    var manufacturer: String
}

struct Coffee: Purchaseable {
    var name: String
    var strength: Int
}

func buy(_ item: Purchaseable) {
    print("I'm buying \(item.name)")
}
//---------------------------------  Protocol inheritance
/* Protokoller birden fazla inheritance alabilir. classlar sadece 1 tane alabiliyor.*/

protocol Payable{
    func calculateWages() -> Int
}
protocol NeedsTraining{
    func study()
}

protocol HasVacation{
    func takeVacation(days : Int)
    
}

protocol Employee : Payable,NeedsTraining,HasVacation{
    
}

//--------------------------------- EXTENSIONS(Uzantılar) //---------------------------------
/*Uzantılar, var olan türlere yöntemler eklemenize, orijinal olarak tasarlanmadıkları şeyleri yapmalarına olanak tanır.
 
 Örneğin, Int türüne bir uzantı ekleyebiliriz, böylece o anki sayının kendisiyle çarpımını döndüren bir squared() yöntemine sahip olur: */

extension Double{
    func square() -> Double{
        return self * self
    }
}

var first = 8.5
first.square()


extension Int{
    var isEven : Bool{
        return self % 2 == 0
    }
}

let number = 16
number.isEven


//---------------------------------   Protocol extensions

extension Collection{
    func summarize(){
        print("there are \(count) of us: ")
        for name in self{
            print(name)
        }
    }
}

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

pythons.summarize()
beatles.summarize()

//---------------------------------    Protocol-oriented programming
/* Protokoller, bir şeyin hangi yöntemlere sahip olması gerektiğini tanımlamamıza izin verir, ancak içindeki kodu sağlamaz.
   Extensionlar, yöntemlerinizin içindeki kodu sağlamanıza izin verir, ancak yalnızca bir veri türünü etkiler. yöntemi aynı anda çok sayıda türe ekleyemezsin.
   Protokol Extension'lar ise bu iki sorunu aynı anda ortadan kaldırır.
*/
protocol Identifiable2{
    var id : String{get set}
    func identify()
}

extension Identifiable2{
    func identify(){
        print("My ID is \(id)")
    }
}

struct UserExtenstion : Identifiable2{
    var id : String
}

let twostraws = UserExtenstion(id: "123123")
twostraws.identify()


//--------------------------------- OPTIONALS  //---------------------------------
var name: String? = nil
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}


func greet(_ name : String?){
    guard let checkName = name else{
        print("You didn't provide a name!")
        return
    }
    print("Hello, \(checkName)!")
}

greet("Burkay")

//---------------------------------

let str = "5"
let num = Int(str)!
//---------------------------------

func userID(for id : Int) -> String?{
    if id == 1 {
        return "Taylor Swift"
    }
    else{
        return nil
    }
}

let user = userID(for: 15) ?? "Anonymous"

//---------------------------------

let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()
let beatle2 = names.last?.lowercased()



enum PasswordError: Error {
    case obvious
}

//---------------------------------

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

//do {
//    try checkPassword("password")
//    print("That password is good!")
//} catch {
//    print("You can't use that password.")
//}

if let result = try? checkPassword("password"){
    print("Result was \(result)")
   } else {
       print("D'oh.")
   }

//--------------------------------- Failable initializers
/* init'İn başına optional koyarak programın çökmesinin önüne geçebiliriz. Burada String olarak 9 haneli bir id girilmesi bekleniyor. Şayet 9 haneli olmaz ise program nil çevirecek.*/
struct idCounter{
    var id : String
    
    init?(id: String){
        if id.count == 9{
            self.id = id
        }
        else{
            return nil
        }
    }
}

let id = idCounter(id: "123123123")

//--------------------------------- Typecasting

class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}

let pets = [Fish(),Dog(),Fish(),Dog()]

for pet in pets{
    if let dog = pet as? Dog{
        dog.makeNoise()
    }
}
