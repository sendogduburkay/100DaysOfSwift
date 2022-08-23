//
//  ViewController.swift
//  Project27
//
//  Created by Muhammed Burkay Şendoğdu on 4.08.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawRectangle()
        
    }
    @IBAction func reDrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType{
        case 0: drawRectangle()
        case 1: drawCircle()
        case 2: drawCheckerboard()
        case 3: drawRotatedSquares()
        case 4: drawLines()
        case 5: drawImageAndText()
        default: break
        }
    }
    
    
    
    func drawRectangle(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        /* Renderer oluşturmak aslında herhangi bir render işlemini başlatmaz - bu, image() yönteminde yapılır. Bu, tüm çizimi yapması gereken kod olan tek parametresi olarak bir kapatmayı kabul eder. Çizilecek bir UIGraphicsImageRendererContext'e referans olan ctx adını verdiğim tek bir parametre iletildi. Bu, çizim kodunun çoğunun yaşadığı CGContext adlı başka bir veri türünün etrafındaki ince bir sarmalayıcıdır.*/
        let img = renderer.image { ctx in
//            awesome drawing codes
            
         /* There are a number of ways of drawing boxes in Core Graphics, but I've chosen the easiest: we'll define a CGRect structure that holds the bounds of our rectangle, we'll set the context's fill color to be red and its stroke color to be black, we'll set the context's line drawing width to be 10 points, then add a rectangle path to the context and draw it.
          
             All five of those are called on the Core Graphics context that comes from ctx.cgContext
          */
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.blue.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle) /* adds a CGRect rectangle to the context's current path to be drawn.*/
            ctx.cgContext.drawPath(using: .fillStroke) /* yapılandırdığınız durumu kullanarak bağlamın geçerli yolunu çizer. */
        }
        imageView.image = img
        
    }
    
    func drawCircle(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5) /* Bu, her kenarda aynı sonucu veren 5 nokta ekler. */
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        
        imageView.image = image
    }
    
    func drawCheckerboard(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.setFillColor(UIColor.blue.cgColor)
            
            for row in 0 ..< 8{
                for col in 0 ..< 8 {
                    if (row+col) % 2 == 0{
                        ctx.cgContext.fill(CGRect(x: row * 64, y: col * 64, width: 64, height: 64))
                        
                    }
                }
            }
        }
        
        imageView.image = img
    }
    
    func drawRotatedSquares(){
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
            
        let img = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotation = 16
            let amount = Double.pi / Double(rotation)
            
            for _ in 0 ..< rotation{
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
                
                ctx.cgContext.setStrokeColor(UIColor.blue.cgColor)
                ctx.cgContext.strokePath()
            }
        }
        imageView.image = img
    }
    
    func drawLines(){
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
            
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                }else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        imageView.image = img
    }
    
    func drawImageAndText(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributeString = NSAttributedString(string: string,attributes: attrs)
            
            attributeString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        imageView.image = img
    }
}
