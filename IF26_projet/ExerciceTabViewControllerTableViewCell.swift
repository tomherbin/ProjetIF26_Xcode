//
//  ExerciceTabViewControllerTableViewCell.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit

class ExerciceTabViewControllerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageExo: UIImageView!
    @IBOutlet weak var titleExo: UILabel!
    @IBOutlet weak var serieExo: UILabel!
    @IBOutlet weak var repetitionExo: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
