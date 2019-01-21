//
//  FirstViewControllerTableViewCell.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit

class FirstViewControllerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titreEntrainement: UILabel!
    var idEntrainement : Int = 0;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
