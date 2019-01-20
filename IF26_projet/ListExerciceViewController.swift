//
//  ListExerciceViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit

var exercice : [Exercice] = []
//var list : [String] = {"fsf","df"}


class ListExerciceViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciceListCell", for: indexPath) as! ListExerciceViewControllerTableViewCell
        cell.exoTitle?.text = exercice[indexPath.item].getTitle()
        cell.exoImage.image = UIImage(named: (exercice[indexPath.row].getTitle() + ".jpeg"))
        cell.exoButton.tag = indexPath.item
        return(cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(myIndex)
        exercice.append(Exercice.init(exerciceKey: 0, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 1, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 2, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 3, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 4, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 5, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey:6, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 7, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 8, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        
    }
    
    
    
    
    
    
}
