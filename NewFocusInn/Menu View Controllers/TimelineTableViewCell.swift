//
//  TimelineTableViewCell.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 2/21/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    // Date Cell
    @IBOutlet weak var dateLabel: UILabel!
    
    // Building Cell
    @IBOutlet weak var buildingTime: UILabel!
    @IBOutlet weak var buildingDescription: UILabel!
    @IBOutlet weak var buildingImage: UIImageView!
    
    // Achievement Cell
    @IBOutlet weak var achievementTime: UILabel!
    @IBOutlet weak var achievementDescription: UILabel!
    @IBOutlet weak var achievementImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
