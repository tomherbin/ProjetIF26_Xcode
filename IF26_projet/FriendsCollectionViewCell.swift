//
//  FriendsCollectionViewCell.swift
//  IF26_projet
//
//  Created by Tom Hache on 20/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var test: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func addFriends(_ sender: Any) {
        
         addButton.setTitle( "ajouté" , for: .normal)
    }
    
}
