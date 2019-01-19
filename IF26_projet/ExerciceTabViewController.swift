//
//  ExerciceTabViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit
import SQLite



class ExerciceTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  private var exerciceArray: [Exercice] = []
    
    @IBOutlet weak var editButton: UIBarButtonItem!
   // var myIndex = 0
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ExerciceTabViewControllerTableViewCell
      cell.titleExo?.text = exerciceArray[indexPath.item].getTitle()
        cell.descriptionExo?.text = exerciceArray[indexPath.item].getDescription()
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
        //doesn't work
        switch tableView.isEditing {
        case true:
            editButton.title = "done"
        case false:
            editButton.title = "edit"
    }
   
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete)
        {
            DataBase.GetInstance().deleteExercice(exerciceKey: exerciceArray[indexPath.row].getKey())
            exerciceArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    
    @IBAction func addExercice(_ sender: Any) {
        DataBase.GetInstance().insertExercice(vc: self)
      //  DataBase.GetInstance().insertExercice(vc: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBase.GetInstance().listTraining()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        exerciceArray = DataBase.GetInstance().getExercice()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "SegueFinal", sender: self)
    }

    
    
}
