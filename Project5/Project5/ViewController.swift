//
//  ViewController.swift
//  Project5
//
//  Created by Muhammed Burkay Şendoğdu on 20.07.2022.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart Game", style: .plain, target: self, action: #selector(startGame))
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty{
            allWords = ["noWord"]
        }
        
        startGame()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text  = usedWords[indexPath.row]
        return cell
    }
    
    func showAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac,animated: true)
    }
    
    @objc func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }))
        present(ac,animated: true)
        
    }
    
   
    func isPossible(word: String) -> Bool{
        guard var mainWord = title?.lowercased() else { return false}
        
        for letter in word{
            if let position = mainWord.firstIndex(of: letter){
                mainWord.remove(at: position)
            }
            else{return false}
        }
        return true
        
    }
    func isReal(word: String) -> Bool{
        if word.count > 3{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        }
        else{
            return false
        }
    }
    
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
    }
    
    func isSame(word: String) -> Bool{
        return title != word.lowercased()
    }
    
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        if isSame(word: lowerAnswer){
        if isReal(word: lowerAnswer){
            if isOriginal(word: lowerAnswer){
                if isPossible(word: lowerAnswer){
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }else{
                    showAlert(title: "Word not possible", message: "You can't spell that word from  \(title!)")}
            }else{
                showAlert(title: "Word used already!", message: "Be more orijinal!")}
        }else{
            showAlert(title: "Word not recognised!", message: "You can't just make them up, you know that!(Less than 3 letters)")}
        }else{
            showAlert(title: "Tricky!", message: "You can't do that!")
        }
        
    }
    

}
