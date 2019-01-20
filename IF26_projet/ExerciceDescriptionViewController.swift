//
//  ExerciceDescriptionViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit

class ExerciceDescriptionViewController: UIViewController {


    @IBOutlet weak var imageExo: UIImageView!
    @IBOutlet weak var titreExo: UILabel!
    @IBOutlet weak var descriptionExo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
          imageExo?.image = UIImage(named: (exerciceArray[indexDescription].getTitle() + ".jpg"))
        titreExo?.text = exerciceArray[indexDescription].getTitle()
        descriptionExo?.text = exerciceArray[indexDescription].getDescription()
    }
    



}
