//
//  SavedJokes.swift
//  RandomJoke
//
//  Created by Brendon Crowe on 1/11/23.
//

import UIKit

class SavedJokes: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: UpdateSavedJokes?
    var savedJokes = [Joke]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        navigationItem.title = "Saved Jokes"
    }
    
    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension SavedJokes: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedJokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        let joke = savedJokes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = joke.setup
        content.secondaryText = joke.punchline
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        savedJokes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        if let delegate = delegate {
            delegate.updateJokes(arrayOfJokes: savedJokes)
        }
    }
}

protocol UpdateSavedJokes: NSObjectProtocol {
    func updateJokes(arrayOfJokes: [Joke])
}
