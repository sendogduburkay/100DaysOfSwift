//
//  ViewController.swift
//  Project1Again
//
//  Created by Muhammed Burkay Şendoğdu on 19.07.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var picturesNumber : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("nssl"){
            pictures.append(item)
        }}
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.title = "\(indexPath.row + 1) of \(pictures.count)"
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }


}

