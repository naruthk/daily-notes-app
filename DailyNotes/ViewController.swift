//
//  ViewController.swift
//  DailyNotes
//
//  Created by Naruth Kongurai on 10/20/17.
//  Copyright © 2017 Naruth Kongurai. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    @IBOutlet weak var newNoteLabel: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var noteTitleLabel: UINavigationItem!
    
    var note: Note?         // Optional .. may be nil
    
    private let welcomeMsg : String = "Touch here to begin typing. Words away!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTextView.delegate = self
        
        // Increase font size to 17
        notesTextView.font = .systemFont(ofSize: 17)
        
        // Set up views if editing an existing Note.
        if let note = note {
            noteTitleLabel.title = "Edit Note"
            notesTextView.text   = note.note
            charCountLabel.text = "\(notesTextView.text.characters.count) characters"
        }
        
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
//        if textView.text == "Distraction-free writing. Forming notes have never been this easy. They shouldn't be hard! Well, happy writing!" || textView.text == welcomeMsg {
//            textView.text = ""
//            textView.textColor = UIColor.black
//        }
    }
    
    //MARK: Navigation
    @IBAction func cancelNoteButton(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
//        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        saveData()
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
            
            //MARK: Save User's Data
            saveData()
        }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        // Do some feedback?
    }
    
//    @IBAction func newNoteButton(_ sender: UIButton) {
//        // Do something when the user hits a new button
//        //  - Perhaps (1) save the note the user made (if it's edited)
//        //  - and (2) form a new note page
//
//        // Haptic feedback when user press the button
//        let generator = UIImpactFeedbackGenerator(style: .heavy)
//        generator.impactOccurred()
//
//        //TODO: Save the user's notes somewhere
//
//        // Reset textview to blank & reset character count to 0
//        notesTextView.text = welcomeMsg
//        charCountLabel.text = "0 character"
//
//    }
    
    private func saveData() {
        let noteMsg = notesTextView.text ?? ""
        let noteDate = dateFormatterToString(calendar: Date.init())
        note = Note(date: noteDate, note: noteMsg)
    }
    
    private func dateFormatterToString(calendar: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: calendar)
    }
    
}

