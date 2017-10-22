//
//  NoteTableViewCell.swift
//  DailyNotes
//
//  Created by Naruth Kongurai on 10/21/17.
//  Copyright © 2017 Naruth Kongurai. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var noteMsg: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
