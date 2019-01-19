//
//  ExerciceTabViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit
import SQLite


 var list = DataBase.GetInstance().getTrainingExercice()
class ExerciceTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    // var list = DataBase.GetInstance().getTrainingString()
   // var myIndex = 0
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ExerciceTabViewControllerTableViewCell
       /* cell.exerciceImage.image = UIImage[named: animals[indexPath.row] + ".jpg"]*/
        cell.titleExo.text = list[indexPath.row]
        cell.desciptionExo.text = list[indexPath.row]
        
      //  cell.textExercice
       // let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell2")
        //cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    //Autoriser le reorder
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = list[sourceIndexPath.row]
        list.remove(at: sourceIndexPath.row)
        list.insert(item, at: destinationIndexPath.row)
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
            list.remove(at: indexPath.row)
            tableView.reloadData()
            DataBase.GetInstance().deleteTraining(trainingId: indexPath.row)
        }
    }
    
    
    
    @IBAction func addExercice(_ sender: Any) {
        DataBase.GetInstance().insertExercice(vc: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBase.GetInstance().listTraining()
    }
    
   

    
    
}
