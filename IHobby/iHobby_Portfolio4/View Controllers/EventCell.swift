//
//  EventCell.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/16/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    // outlets for my cell labels and views
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
