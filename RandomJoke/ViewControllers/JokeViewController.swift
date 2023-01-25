// Random Joke Generator 

import UIKit


class JokeViewController: UIViewController, UpdateSavedJokes {
    
    
    @IBOutlet weak var faceButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    private let jokeAPI = "https://official-joke-api.appspot.com/jokes/random"
    private var currentJoke: Joke?
    var savedJokes = [Joke]()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Press the face for a Joke!"
    }
    
    @IBAction func generateJoke(_ sender: UIButton) {
        loadData(from: jokeAPI)
    }
    
    @IBAction func saveJoke(_ sender: UIButton) {
        saveJoke(currentJoke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? SavedJokes else { return }
        dvc.savedJokes = savedJokes
        dvc.delegate = self // JokeViewController is now listening for changes. When delegate is called, JokeViewController knows and will implement updateJokes()
    }
    
    func updateJokes(arrayOfJokes: [Joke]) {
        savedJokes = arrayOfJokes
    }
    
    func saveJoke(_ joke: Joke?) {
        if let joke = joke {
            if !savedJokes.contains(joke) {
                savedJokes.append(joke)
            } else {
                let alert = UIAlertController.init(title: "oops", message: "joke already saved", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                present(alert, animated: true)
                return
            }
        }
    }
    
    func loadData(from url: String) {
        JokeAPIClient.getJoke(with: url, completion: { [unowned self] (result) in
            switch result {
            case .failure(let error):
                print("error: \(error)")
            case .success(let joke):
                self.currentJoke = joke
                DispatchQueue.main.async {
                    self.label.text = "\(self.currentJoke?.setup ?? "no setup") \n \n \(self.currentJoke?.punchline ?? "no punchline")"
                }
            }
        })
    }
}
