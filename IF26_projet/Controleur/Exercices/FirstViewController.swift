//
//  FirstViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit
import SQLite
/**
Variable global permettant de faire passer l'indice de la cellule cliquer sur la prochaine vue
 */
  var myIndex = 0
/**
 Controleur de la vue de la liste des entrainements (page d'accueil)
 */
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    private var trainingArray: [Entrainement] = []
    /**
     Compter le nombre de cellule à afficher dans le listView
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingArray.count
    }
    /**
     Chargement du contenu des cellules
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstViewControllerTableViewCell
        cell.titreEntrainement?.text = trainingArray[indexPath.item].getTitle()
        return(cell)
    }
    /**
     Autoriser le reorder des cellules
     */
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /**
     Modification de l'emplacement des cellules
     */
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = trainingArray[sourceIndexPath.row]
        trainingArray.remove(at: sourceIndexPath.row)
        trainingArray.insert(item, at: destinationIndexPath.row)
    }
    
    /**
     Activer la modification de l'emplacement des cellules
     */
    @IBAction func rearrange(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
    }
    /**
     Effacer un entrainement en glissant la cellule à gauche
     */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete)
        {
            DataBase.GetInstance().deleteTraining(trainingId: trainingArray[indexPath.row].getKey())
            trainingArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    /**
     Charger l'indice de la cellule sélectionné et passer à la vue suivante dont le chemin est nommé "Segue"
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "Segue", sender: self)
    }
    /**
     Ajouter un entrainement à la base de données en affichant une boite de dialogue
     */
    @IBAction func addTraining(_ sender: UIBarButtonItem) {
        DataBase.GetInstance().insertEntrainement(vc: self)
    }
    /**
     Chargement de la vue
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        trainingArray = DataBase.GetInstance().getTraining()
        
    }
    /**
     Chargement lorsque qu'on revient sur la vue
     */
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        trainingArray = DataBase.GetInstance().getTraining()
        self.tableView.reloadData()
    }
    
    
  
    
}

