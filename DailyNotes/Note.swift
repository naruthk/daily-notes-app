//
//  Note.swift
//  DailyNotes
//
//  Created by Naruth Kongurai on 10/21/17.
//  Copyright © 2017 Naruth Kongurai. All rights reserved.
//

import UIKit

class Note {
    
    //MARK: Properties
    var date: String
    var note: String
    
    //MARK: Initialization
    init?(date: String, note: String) {
        guard !note.isEmpty else {
            return nil
        }
        self.date = date
        self.note = note
    }
    
}
