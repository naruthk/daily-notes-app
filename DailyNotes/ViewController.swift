//
//  ViewController.swift
//  DailyNotes
//
//  Created by Naruth Kongurai on 10/20/17.
//  Copyright © 2017 Naruth Kongurai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var newNoteLabel: UIButton!
    
    private let welcomeMsg : String = "Touch here to begin typing. Words away!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTextView.delegate = self
        
        // Create a "Done" keyword
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        notesTextView.inputAccessoryView = toolbar
        
        // Prior to user editing text, the color of the textview will be slighter lighter
        notesTextView.textColor = UIColor.darkGray
        
        charCountLabel.textColor = UIColor.darkGray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextViewDelegate
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Distraction-free writing. Forming notes have never been this easy. They shouldn't be hard! Well, happy writing!" || textView.text == welcomeMsg {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    //MARK: Actions
    @objc func doneClicked() {
        self.view.endEditing(true)  // Hide the keyboard
        notesTextView.textColor = UIColor.darkGray  // Set the note color back to gray
        
        let charCount = notesTextView.text.characters.count
        if charCount == 0 {
            charCountLabel.text = "0 character"
            notesTextView.text = welcomeMsg
        } else {
            charCountLabel.text = String(charCount) + " characters"
            
            //TODO: Save the user's data
            // - Save the date (timestamp)
            // - Cache it in a data server
            // - Perhaps user's iCloud / physical device storage
            
            
            
        }
    }
    
    @IBAction func newNoteButton(_ sender: UIButton) {
        // Do something when the user hits a new button
        //  - Perhaps (1) save the note the user made (if it's edited)
        //  - and (2) form a new note page
        
        // Haptic feedback when user press the button
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        //TODO: Save the user's notes somewhere
        
        // Reset textview to blank & reset character count to 0
        notesTextView.text = welcomeMsg
        charCountLabel.text = "0 character"
        
    }
    
}

