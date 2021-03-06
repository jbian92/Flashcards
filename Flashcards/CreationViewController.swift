//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Julia Bian on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {

    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    // allows creation view controller to access the flashcards controller
    var flashcardsController: ViewController!


    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        // get text in question text field
        let questionText = questionTextField.text
        
        // get text in answer text field
        let answerText = answerTextField.text
        
        // call the function to update flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        // dismiss
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
