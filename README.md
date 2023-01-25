# Random Joke App

This app was built as an assessment for making an HTTP Get request, decoding JSON, and displaying the JSON data in a table view.

## Noteworthy code 
In order to keep track of saved jokes, an array must be used on the source controller. However, there is an issue when passing data. In prepare for segue, the table view controller has an array value that gets set to the value of saved jokes on the source controller. The issue is when you delete a joke, and go back to the source controller, the array does not know that a joke was deleted, and it keeps "pushing" itself, which means the joke never gets deleted. Therefore, a protocol was created in order to use the delegate method of programming. 

``` Swift
protocol UpdateSavedJokes: NSObjectProtocol {
    func updateJokes(arrayOfJokes: [Joke])
}
```

``` Swift 
 if let delegate = delegate {
            delegate.updateJokes(arrayOfJokes: savedJokes)
        } // used wherever you want data to be passed (i.e a button was pressed)
 ```
 
 ``` Swift 
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? SavedJokes else { return }
        dvc.savedJokes = savedJokes
        dvc.delegate = self // JokeViewController is now listening for changes. When delegate is called, JokeViewController knows and will implement updateJokes()
    }
    
    func updateJokes(arrayOfJokes: [Joke]) {
        savedJokes = arrayOfJokes
    }
 ```
        

### Gif
![Random-Joke-Gif](Assets/RandomJokeGif.gif)
