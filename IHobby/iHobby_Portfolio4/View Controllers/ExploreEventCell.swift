//
//  ExploreEventCell.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/22/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit

class ExploreEventCell: UITableViewCell {

    // outlets
    @IBOutlet weak var exploreTitle: UILabel!
    @IBOutlet weak var exploreDate: UILabel!
    @IBOutlet weak var exploreTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
