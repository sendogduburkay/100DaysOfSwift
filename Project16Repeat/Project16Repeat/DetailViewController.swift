//
//  DetailViewController.swift
//  Project16Repeat
//
//  Created by Muhammed Burkay Şendoğdu on 30.07.2022.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    var webView: WKWebView!
    var selectedCapital: String?
    var url = "https://en.wikipedia.org/wiki/"
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedCapital = selectedCapital {
            webView.load(URLRequest(url: URL(string: url+selectedCapital)!))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
