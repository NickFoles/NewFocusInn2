//
//  AchievementsTableViewCell.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 3/25/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit

class AchievementsTableViewCell: UITableViewCell {
    @IBOutlet weak var badge: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cellDescription: UILabel!

    @IBOutlet weak var messageConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
