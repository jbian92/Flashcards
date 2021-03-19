//
//  ViewController.swift
//  Flashcards
//
//  Created by Julia Bian.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel! // flashcard question
    @IBOutlet weak var backLabel: UILabel! // flashcard answer
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // multiple choice buttons
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        // show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        
        present(alert, animated: true)
        
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
    }
    
    func deleteCurrentFlashcard() {
        flashcards.remove(at: currentIndex)
        
        // special case: last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    // array to hold flashcards
    var flashcards = [Flashcard]()
    
    // current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        // Adds rounded corners
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
                
        // Adds shadows to card
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        // Adds borders to buttons
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.1426051557, green: 0.09837561101, blue: 0.2860302031, alpha: 1)
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.1426051557, green: 0.09837561101, blue: 0.2860302031, alpha: 1)
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.1426051557, green: 0.09837561101, blue: 0.2860302031, alpha: 1)
        
        // read saved flashcards
        readSavedFlashcards()
        
        // add initial flashcard if needed
        if flashcards.count == 0 {
            // first flashcard
            updateFlashcard(question: "Which sea creature has three hearts?", answer: "octopus")
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden == true) {
            frontLabel.isHidden = false
        }
        else {
            frontLabel.isHidden = true
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        
        // add flashcard to array
        flashcards.append(flashcard)
        
        // logging to the console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        // update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // update next/prev buttons
        updateNextPrevButtons()
        
        // update labels after current index is updated
        updateLabels()
        
        // save to disk
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        // increase current index
        currentIndex = currentIndex + 1
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        // decrease current index
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    func updateLabels() {
        // get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    // user taps on the first button
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    // user taps on the second button
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    // user taps on the third button
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    
    func updateNextPrevButtons() {
        // disable next button if at the end of flashcards
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        
        // disable prev button if at beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
    }
    
    // save to disk so can retrieve them again when reopen app
    func saveAllFlashcardsToDisk() {
        // from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        // save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    // read previously saved flashcards (if any)
    func readSavedFlashcards() {
        /*
        - read dictionary array from disk (if any)
        - if let statement allows us to define a constant, in this case dictionaryArray, if and only if there's a value returned by UserDefaults
        - as? [[String: String]] is needed as we need to tell Swift that we're expecting dictionaryArray to be an array of dictionaries where both the keys and values are Strings
        */
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            
            // convert an array of dictionaries to an array of Flashcards
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                // need the ! to tell Swift that we're 100% sure that the dictionary has a value there for "question" and for "answer"
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // desitnation of segue is Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // set flashcardsController property to self
        creationController.flashcardsController = self
    }
}

