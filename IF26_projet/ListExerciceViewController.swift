//
//  ListExerciceViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit


//var list : [String] = {"fsf","df"}


class ListExerciceViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var exercice : [Exercice] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciceListCell", for: indexPath) as! ListExerciceViewControllerTableViewCell
        cell.exoTitle?.text = exercice[indexPath.item].getTitle()
        cell.exoImage.image = UIImage(named: (exercice[indexPath.row].getTitle() + ".jpg"))
        cell.exoButton.tag = indexPath.item + 1
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myIndex)
       BanqueExercice.GetInstance()
        exercice = DataBase.GetInstance().getExercice()
    }
    
    
    
    
    
    
}
