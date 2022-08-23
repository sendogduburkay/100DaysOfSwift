//
//  ViewController.swift
//  Project7
//
//  Created by Muhammed Burkay Şendoğdu on 22.07.2022.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetition = [Petition]()
    var backupPetitions = [Petition]()
    var counter = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(credits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetition))
        
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString){
            if let urlData = try? Data(contentsOf: url){
                parse(json: urlData)
                return
            }
        }
        showError()
        
    }
    
    @objc func filterPetition(){
        if counter{
        let ac = UIAlertController(title: "Filter Petitions", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Filter", style: .default, handler: { _ in
            guard let filteredWord = ac.textFields?[0].text else{return}
            self.performSelector(inBackground: #selector(self.filterWord(filteredword:)),with: filteredWord)
        }))
            present(ac,animated: true)
            counter = false
        }
        
        else{
            let ac = UIAlertController(title: "Filter Petitions", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.addAction(UIAlertAction(title: "Clear Filter", style: .destructive, handler: clearFilter))
            ac.addAction(UIAlertAction(title: "Filter", style: .default, handler: { _ in
                guard let filteredWord = ac.textFields?[0].text else{return}
                self.filterWord(filteredword: filteredWord)
            }))
                present(ac,animated: true)
            
        }
         
    }
    
    @objc func filterWord(filteredword: String){
        for item in petitions{
            if item.body.lowercased().contains(filteredword.lowercased()){
                filteredPetition.append(item)
            }
        }
        print(filteredPetition.count)
        petitions = filteredPetition
        filteredPetition.removeAll(keepingCapacity: true)
        tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        
    }
    
    func clearFilter(action: UIAlertAction){
        petitions = backupPetitions
        tableView.reloadData()
    }
    
    
    @objc func credits(){
        let ac = UIAlertController(title: nil, message: "the data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac,animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            backupPetitions = petitions
            tableView.reloadData()
    }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

