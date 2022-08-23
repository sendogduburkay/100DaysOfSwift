//
//  ActionViewController.swift
//  Extension
//
//  Created by Muhammed Burkay Şendoğdu on 30.07.2022.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {

    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
            if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem{ /*Uzantımız oluşturulduğunda Context, ana uygulamayla nasıl etkileşime gireceğini kontrol etmemizi sağlar.Inputitems durumunda bu, ana uygulamanın kullanmak üzere uzantımıza gönderdiği bir veri dizisi olacaktır. First dediğimiz için ilk itemi alıyoruz.*/
                if let itemProvider = inputItem.attachments?.first { /* inputItem bize attachmentslerin olduğu bir dizi döndürür. bu veriler NSItemProvider olarak paketlenmiştir. */
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] dict, error in
                    /*
                       itemprovider'dan bize öğesini gerçekten sağlamasını istemek için loadItem(forTypeIdentifier: ) kullanır, Closure açıp asenkron olarak çalıştırılıyor çünkü itemProvider bize data yükleme ve gönderme işlemi yaparken metod çalışmaya devam edebilsin diye. */
                    guard let itemDictionary = dict as? NSDictionary else { return } /* Gelen verileri dictionary olarak almaya çalışıyor.*/
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }/* javaScriptten bir dizide data yolluyoruz o yüzden tekrar NSDictionary ile typecasting yaptık.*/
                        
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
        
    }
    
        
    @IBAction func done() {
        
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]

        extensionContext?.completeRequest(returningItems: [item])
    }

}
