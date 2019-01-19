//
//  FirstViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit
import SQLite

  var myIndex = 0

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    private var trainingArray: [Entrainement] = []
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstViewControllerTableViewCell
        print(trainingArray[indexPath.item].getTitle())
        cell.titreEntrainement?.text = trainingArray[indexPath.item].getTitle()
        return(cell)
    }
    
    //Autoriser le reorder
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = trainingArray[sourceIndexPath.row]
        trainingArray.remove(at: sourceIndexPath.row)
        trainingArray.insert(item, at: destinationIndexPath.row)
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
            DataBase.GetInstance().deleteTraining(trainingId: trainingArray[indexPath.row].getKey())
            trainingArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "Segue", sender: self)
    }
    
    @IBAction func addTraining(_ sender: UIBarButtonItem) {
        DataBase.GetInstance().insertEntrainement(vc: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainingArray = DataBase.GetInstance().getTraining()
        
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        trainingArray = DataBase.GetInstance().getTraining()
        self.tableView.reloadData()
    }
    
    
    
    
}

