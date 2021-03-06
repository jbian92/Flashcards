//
//  ViewController.swift
//  Flashcards
//
//  Created by Julia Bian.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel! // flashcard question
    @IBOutlet weak var backLabel: UILabel! // flashcard answer
    @IBOutlet weak var card: UIView!
    
    // multiple choice buttons
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
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
        frontLabel.text = question
        backLabel.text = answer
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // desitnation of segue is Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // set flashcardsController property to self
        creationController.flashcardsController = self
    }
}

