import UIKit
import Foundation


// ------------------------------------ STRINGTEN DİZİDEKİ GİBİ ELEMAN ÇEKEBİLME İŞLEMİ ( INDEX SAYDIRMA )   ------------------------------------


//var name = "burkay"
//
//for letter in name{
//    print(letter)
//}
//
//
//let letter = name[name.index(name.startIndex, offsetBy: 3)]
//
//
//
//
//extension String{
//    subscript(i: Int) -> String{
//        return String(self[index(startIndex,offsetBy: 3)])
//    }
//}
//
//let letter2 = name[3]

// ------------------------------------ SUFFIX PREFİX EXTENSION KULLANIMI  ------------------------------------

let password = "12345"
password.hasSuffix("345")
password.hasPrefix("123")


extension String{
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

password.deletingPrefix("123")
password.deletingSuffix("45")

// ------------------------------------ METNİN HER GİRİLEN KELİMESİNİN BAŞINI BÜYÜK YAZIYOR.  ------------------------------------

let weather = "it's going to rain"
weather.capitalized

extension String{
    var capitalizedString: String{
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}
weather.capitalizedString

// ------------------------------------ METİN İÇİNDE ARAMA YAPMA   ------------------------------------

let input = "Swift is like Objective-C without C"
let swift = "Swift"
input.contains("Swift")

let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")

extension String{
    func containsAny(of array: [String]) -> Bool{
        for item in array{
            if self.contains(item){
                return true
            }
        }
        return false
    }
}
/* Bu kesinlikle işe yarıyor, ancak zarif değil - ve Swift'in yerleşik daha iyi bir çözümü var. */
input.containsAny(of: languages)
/* contains(where:) will call its closure once for every element in the languages array until it finds one that returns true, at which point it stops.

 In that code we’re passing input.contains as the closure that contains(where:) should run. This means Swift will call input.contains("Python") and get back false, then it will call input.contains("Ruby") and get back false again, and finally call input.contains("Swift") and get back true – then stop there.
 */
languages.contains(where: input.contains)
swift.contains(where: input.contains)


// ------------------------------------ NSATTRIBUTESTRING   ------------------------------------
/* It’s common to use an explicit type annotation when making attributed strings, because inside the dictionary we can just write things like .foregroundColor for the key rather than NSAttributedString.Key.foregroundColor.*/

let string = "This is a test string"
//let attributes: [NSAttributedString.Key: Any] = [
//    .backgroundColor:  UIColor.gray,
//    .foregroundColor:  UIColor.red,
//    .font: UIFont.boldSystemFont(ofSize: 36)
//
//]
//let attributeString = NSAttributedString(string: string, attributes: attributes)
//
let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


let homeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))

let text = NSMutableAttributedString(string: "hello, world!")

let attrs = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.patternDash.rawValue | NSUnderlineStyle.single.rawValue]

text.addAttributes(attrs, range: NSRange(location: 0, length: text.length))

homeLabel.attributedText = text



// ------------------------------------ WRAP UP   ------------------------------------

extension String{
    func withPrefix(_ prefix: String) -> String{
        if self.contains(prefix){
            return self
        }
        else{
            return (prefix + self)
        }
    }
    
    var lines: [String.SubSequence] {
        self.split(separator: " ")
    }
    var isNumeric: Bool{
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = self.rangeOfCharacter(from: decimalCharacters)
        if decimalRange != nil{
            return true
        }
        return false
    }
}

let input2 = "Swift is like Objective-C without C2"
input2.isNumeric
let array = string.lines
array.count
let kay = "kay"
kay.withPrefix("bur")

