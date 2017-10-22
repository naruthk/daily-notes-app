//
//  Note.swift
//  DailyNotes
//
//  Created by Naruth Kongurai on 10/21/17.
//  Copyright © 2017 Naruth Kongurai. All rights reserved.
//

import UIKit
import os.log

class Note : NSObject, NSCoding {
    
    //MARK: Properties
    var date: String
    var note: String
    
    struct PropertyKey {
        static let note = "note"
        static let date = "date"
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("notes")
    
    //MARK: Initialization
    init?(date: String, note: String) {
        guard !note.isEmpty else {
            return nil
        }
        self.date = date
        self.note = note
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(note, forKey: PropertyKey.note)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let noteMsg = aDecoder.decodeObject(forKey: PropertyKey.note) as? String else {
            os_log("Unable to decode the message for a Note object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let noteDate = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
            os_log("Unable to decode the date for a Note object.", log: OSLog.default, type: .debug)
            return nil
        }
       
        // Must call designated initializer.
        self.init(date: noteDate, note: noteMsg)
        
    }
}
