import UIKit
//--------------------//--------------------//--------------------
enum WeatherType{
    case sun
    case rain
    case cloud
    case wind(speed: Int)
    case snow
}


func getHaterStatus(weather : WeatherType) -> String?{
    switch weather{
    case .sun: return nil
    case .cloud: return ("I don't like it")
    case .wind(let speed) where speed < 10:
        return "Meh"
    case .rain: return ("FUCK!")
    default: return "Eh"
    }
}

let hater = getHaterStatus(weather: .rain)
print(hater?.uppercased())
getHaterStatus(weather: .wind(speed: 5))
//--------------------//--------------------//--------------------

func knockKnock(_ caller: String?){
    switch caller{
    case .none:
        print("silence")
    case .some(let person):
        print(person)
    }
    
}

//--------------------//--------------------//--------------------
//
//
//struct Person{
//    var clothes: String
//    var shoes: String
//}
//
//let taylar = Person(clothes: "T-shirts", shoes: "sneakers")
//let other = Person(clothes: "short skirts", shoes: "high heels")
//var taylarCopy = taylar
//taylarCopy.clothes = "Gazak"
//print(taylar)
//print(taylarCopy)

//--------------------//--------------------//--------------------

class Singer{
    var name: String
    var age: Int
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
    
    func sing(){
        print("Lalalala")
    }
}
class CountrySinger: Singer{
    override func sing() {
        print("Trucks,guitars and liquor")
    }
    
}

class HeavyMetalSinger: Singer{
    var noiceLevel : Int
    init(name: String, age: Int, noiceLevel: Int) {
        self.noiceLevel = noiceLevel
        super.init(name: name, age: age)
    }
    override func sing() {
           print("Grrrrr rargh rargh rarrrrgh!")
       }
    
}


var taylor = CountrySinger(name: "Taylor", age: 28)
taylor.sing()
taylor.age
taylor.name

//--------------------//--------------------//--------------------

//struct Person{
//    var clothes: String
//    var shoes: String
//
//    func describe(){
//        print("i like wearing \(clothes) with \(shoes)")
//    }
//}
//
//let taylor2 = Person(clothes: "Tshirt", shoes: "Sneakers")
//let other2 = Person(clothes: "short skirts", shoes: "high heels")
//taylor2.describe()
//other2.describe()

//--------------------//--------------------//--------------------

struct Person{
    var clothes: String{
        willSet{
            updateUI(msg: "I'm changing from \(clothes) to \(newValue)")
        }
        didSet{
            updateUI(msg: "I just changed from \(oldValue) to \(clothes)")
        }
    }
    func updateUI(msg: String){
        print(msg)
    }
}

var taylor123 = Person(clothes: "Tshirt")
taylor123.clothes = "shirt"

//--------------------//--------------------//--------------------
/*Sahne arkasında aslında kod olan özellikler yapmak mümkündür. Örneğin, stringlerin büyük harfli () yöntemini zaten kullandık, ancak her dizenin her zaman kendisinin büyük harfli bir sürümünü depolaması yerine, gerektiği gibi hesaplanan büyük harf olarak adlandırılan bir özellik de var.*/

struct PersonAge{
    var age: Int
    var ageInDogYears: Int{
        get{
        return age * 7
        }
    }
}

var fan = PersonAge(age: 15)
fan.ageInDogYears

//--------------------//--------------------//-------------------- POLYMORPHISM

class Album{
    var name: String
    init(name: String){
        self.name = name
    }
    
    func getPerformance() -> String{
        return "The album \(name) sold lots."
    }
}

class StudioAlbum: Album{
    var studio: String
    init(name: String,studio: String){
        self.studio = studio
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots."
    }
}

class LiveAlbum: Album{
    var location: String
    init(name: String,location: String){
        self.location = location
        super.init(name: name)
    }
    override func getPerformance() -> String {
        return "The live album \(name) sold lots."
    }
}


var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums : [Album] = [taylorSwift,fearless,iTunesLive]

for album in allAlbums{
    print(album.getPerformance())
    
    if let studioAlbum = album as? StudioAlbum{
        print(studioAlbum.studio)
    }
    else if let liveAlbum = album as? LiveAlbum{
        print(liveAlbum.location)
    }
}


let number = 5
let text = String(number)
