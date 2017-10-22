//
//  NoteTableViewController.swift
//  DailyNotes
//
//  Created by Naruth Kongurai on 10/21/17.
//  Copyright © 2017 Naruth Kongurai. All rights reserved.
//

import UIKit
import os.log

class NoteTableViewController: UITableViewController {
    
    //MARK: Properties
    var notes = [Note]()     // an empty array of Note
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // Load any saved notes, otherwise load sample data.
        if let savedNotes = loadNotes() {
            notes += savedNotes
        } else {
            // Load the sample note data
            loadSampleNotes()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NoteTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteTableViewCell else {
            fatalError("The dequeued cell is not an instance of NoteTableViewCell")
        }
        
        // Fetches the appropriate note for the data source layout
        let note = notes[indexPath.row]
        cell.noteMsg.text = note.note
        cell.noteDate.text = note.date
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            // Save the notes.
            saveNotes()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "AddNote":
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                os_log("Adding a new note.", log: OSLog.default, type: .debug)
            case "ShowDetail":
                guard let noteDetailViewController = segue.destination as? ViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedNoteCell = sender as? NoteTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                
                guard let indexPath = tableView.indexPath(for: selectedNoteCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let selectedNote = notes[indexPath.row]
                noteDetailViewController.note = selectedNote
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToNoteList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let note = sourceViewController.note {
            // In case the user wants to edit an existing note...
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing note.
                notes[selectedIndexPath.row] = note
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new note
                let newIndexPath = IndexPath(row: notes.count, section: 0)
                notes.append(note)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the notes.
            saveNotes()
        }
    }
    
    //MARK: Private Methods
    private func loadSampleNotes() {
        let sampleMsg1 = "Buy eggs for next week's grocery shopping."
        let sampleDate1 = dateFormatterToString(calendar: Date.init())
        
        let sampleMsg2 = "Welcome to Daily Notes app! Don't forget to rate the app!"
        let sampleDate2 = dateFormatterToString(calendar: Date.init())
        
        guard let note1 = Note(date: sampleDate1, note: sampleMsg1) else {
            fatalError("Unable to instantiate note")
        }
        
        guard let note2 = Note(date: sampleDate2, note: sampleMsg2) else {
            fatalError("Unable to instantiate note")
        }
        
        notes += [note1, note2]
    }

    private func dateFormatterToString(calendar: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: calendar)
    }
    
    private func saveNotes() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(notes, toFile: Note.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Notes successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save notes...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadNotes() -> [Note]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Note.ArchiveURL.path) as? [Note]
    }

}
