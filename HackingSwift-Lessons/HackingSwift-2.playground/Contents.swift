import UIKit
/*                      STRUCT İLE CLASS ARASINDAKİ FARKLAR
 1- Class'ta init kullanılmadan değişken tanımlanamıyor.
 2- Var olan bir sınıftan yeni bir sınıf oluşturabilirsin.
 3- Class'ta bir değişkeni yeni bir değişkene eşitledik. Eğer eşitlediğimiz değişkenin değeri değiştirilir ise ana değişkenin de içeriği değişiyor. Bunun olmasını istemiyor isek sadece let ile tanımlamak yetiyor.
 4- Sınıflarda deinit kullanılabiliyor.
 5- Struct oluşturulduğunda eğer bir değişkeni değiştirilebilir yapmak istiyor isek "Mutating" anahtar kelimesini kullanmamız gerekiyor. Sınıfta hiçbir şey belirtmek zorunda değilsin.
 */

//------------------------------------------------  STRUCTS

struct Sport{
    var name : String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)
tennis.name = "Football"
print(tennis.name)


struct Progress{
    var task : String
    var amount : Int{
        didSet{
            print("\(task) is now \(amount)% complete.")
        }
    }
    
}

var progress = Progress(task: "Loading Data", amount: 0)
progress.amount = 30
progress.amount = 100

struct City{
    var population : Int
    
    func collectTaxes() -> Int{
        return population * 1000
    }
}

var ankara = City(population: 5_600_00)
print(ankara.collectTaxes())

//------------------------------------------------ MUTATING METHODS IN STRUCT
/* Eğer verinin değiştirilebileceğğini mutating ile belirtmezsek Swift otomatik olarak nonmutating olarak alır. Dolayısıyla sabit değer verilen hiçbir şeyi değiştiremeyiz. Eğer değiştirmek istiyorsak mutating ile fonksiyonu oluşturmamız gerekiyordu.*/
struct Person{
    var name : String
    
    mutating func makeAnonymous(){
        name = "Anonymous"
    }
}

var personName = Person(name: "Burkay222")
print(personName.name)


var arrayOfFirst = ["Anonymous","Burkay","Tennis","Football"]
arrayOfFirst.firstIndex(of: "Tennis")

//------------------------------------------------  INITIALIZERS
struct UserWithoutInıt{
    var username : String
    
}
var userWithoutInıt = UserWithoutInıt(username: "Burkay")
print(userWithoutInıt.username)


struct User{
    var username : String
    
    init(){
        username = "Anonymous"
        print("Creating a new user")
    }
}

var user = User()
user.username = "Burkay Şendoğdu"


struct Person2{
    var name : String
    init(name2 : String){
        print("\(name2) was born!")
        self.name = name2
    }
}

var personWhoBorn = Person2(name2: "Burkay")
print(personWhoBorn.name)

//------------------------------------------------  INITIALIZERS - LAZY PROPERTIES

struct FamilyTree{
    init(){
        print("Creating family tree!")
    }
}

struct thePerson{
    var name : String
    lazy var familyTree = FamilyTree()
    
    init(name: String){
        self.name = name
    }
}

var burkay = thePerson(name: "Gülten")
burkay.familyTree

//------------------------------------------------  INITIALIZERS - STATIC PROPERTIES
/* Aşağıda Student'ta kaç tane öğrenci kaydı oluştuğunun bilgisini veren bir özellik ekledik. Statik olarak belirlememiz bu özelliğin sadece struct adı ile çağrılabilmesini sağlıyor ve struct'ın bir özelliği ya da yönteminden bilgi almamızı sağlıyor.
    Statik bir değişken oluşturduğumuz zaman kesinlikle ya init ya da bir değer vermemiz gerekiyor.*/

struct Student {
    var name: String
    static var classSize = 0
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")

print(Student.classSize)

//------------------------------------------------  INITIALIZERS - PRIVATE PROPERTIES ( ACCESS CONTROL )

struct PersonId {
    private var id: String

    init(id: String) {
        self.id = id
    }

    func identify() -> String {
        return "My social security number is \(id)"
        
    }
    
}

var gulten = PersonId(id: "12345")
gulten.identify()



//------------------------------------------------  CLASSES //------------------------------------------------

class Dog{
    var name : String
    var breed : String
    func makeNoise(){
        print("Woof!")
    }
    
    init(name : String,breed: String){
        self.name = name
        self.breed = breed
    }
}

let husky = Dog(name: "Bruh", breed: "Husky")

//------------------------------------------------  INHERITANCE CLASS AND USING INIT
class Poodle : Dog{
    init(name: String){
        super.init(name: name, breed: "Poodle")
    }
}

class Husky : Dog{
    init (name:String){
        super.init(name: name, breed: "Husky")
    }
    override func makeNoise() {
        print("Fuck Woof!")
    }
}
let poppy = Poodle(name: "Poppy")
let newHusky = Husky(name: "Bruh2")
poppy.makeNoise()
newHusky.makeNoise()

//------------------------------------------------  FINAL CLASS

 final class Dogs{
    var name : String
    var breed : String
    init(name: String, breed: String) {
           self.name = name
           self.breed = breed
       }
}
// Final Class'tan inheritance alınamaz!
//class Rottweiler : Dogs{
//    init(name: String){
//        super.init(name: name, breed: "Poodle")
//    }
//}


//------------------------------------------------  COPYING OBJECTS
/*Class'ta ilk değişkenden ikincisine ismi atadık. İkinci değişkenin değerini değiştirdiğimiz zaman ilkinin de değeri değişiyor.
 Struct'ta ise ilkinin değeri ile ikincinin değeri ayrı ayrı tutuluyor. İkincinin değeri değiştirildiğinde ilk değişkenin değeri değişmiyor.
 */
class Singer{
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)
var singerCopy = singer
singerCopy.name = "Justin Bieber"
print(singer.name)

struct StructSinger{
    var name = "Taylor Swift"
}

var structSinger = StructSinger()
print(structSinger.name)
var structSinger2 = structSinger
structSinger2.name = "Eminem"
print(structSinger.name)

//------------------------------------------------  DEINIT

class AlivePerson{
    var name = "John Doe"
    init(){
        print("\(name) is alive!")
    }
    func printGreeting() {
          print("Hello, I'm \(name)")
      }
    deinit{
        print("\(name) is dead!")
    }
}

for i in 1...3{
    let person = AlivePerson()
    person.printGreeting()
}


//------------------------------------------------  MUTABILITY

class SingerMutability{
//    let name = "Taylor Swift" Değiştirilmesini istemiyor isek let ile tanımlayacağız.
    var name = "Taylor Swift"
}

let taylorSwift = SingerMutability()
taylorSwift.name = "Ed Sheeran"
print(taylorSwift.name)

