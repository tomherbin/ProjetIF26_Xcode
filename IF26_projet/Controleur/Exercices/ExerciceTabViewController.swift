//
//  ExerciceTabViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit
import SQLite

var indexDescription = 0
 var exerciceArray: [Exercice] = []

class ExerciceTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ExerciceTabViewControllerTableViewCell
      cell.titleExo?.text = exerciceArray[indexPath.item].getTitle()
        cell.serieExo?.text = String(exerciceArray[indexPath.item].getSerie())
        cell.repetitionExo?.text = String(exerciceArray[indexPath.item].getRepetition())
        cell.imageExo?.image = UIImage(named: (exerciceArray[indexPath.item].getTitle() + ".jpg"))
        
        return(cell)
        
    }
    
    //Autoriser le reorder
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = exerciceArray[sourceIndexPath.row]
        exerciceArray.remove(at: sourceIndexPath.row)
        exerciceArray.insert(item, at: destinationIndexPath.row)
    }
    
    @IBAction func rearrange(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete)
        {
            DataBase.GetInstance().deleteProgramme(exerciceKey: exerciceArray[indexPath.row].getKey(), trainingKey : myIndex)
            exerciceArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    
    @IBAction func addExercice(_ sender: Any) {
        DataBase.GetInstance().insertExercice(vc: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBase.GetInstance().listTraining()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        exerciceArray = DataBase.GetInstance().getExerciceFromTraining(key: myIndex)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexDescription = indexPath.row
        performSegue(withIdentifier: "SegueFinal", sender: self)
    }

    
    
}