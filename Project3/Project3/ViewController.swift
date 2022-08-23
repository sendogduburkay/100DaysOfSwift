//
//  ViewController.swift
//  Project3
//
//  Created by Muhammed Burkay Şendoğdu on 20.07.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        for item in items {
            if item.hasPrefix("nssl")
            {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController{
            vc.selectedPicture = pictures[indexPath.row]
            vc.title = "\(indexPath.row+1) of \(pictures.count)"
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

