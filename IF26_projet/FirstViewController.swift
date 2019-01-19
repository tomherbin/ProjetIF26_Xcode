//
//  FirstViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit
import SQLite

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var list = DataBase.GetInstance().getTrainingTitle()
    var idList = DataBase.GetInstance().getTrainingKey()
    var myIndex = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstViewControllerTableViewCell
        //cell.textLabel?.text = list[indexPath.row]
        cell.titreEntrainement.text = list[indexPath.row]
        //  cell.idEntrainement = idList[indexPath.row]
        
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
            
           // DataBase.GetInstance().deleteTraining(trainingId: idList[indexPath.row])
           // idList.remove(at: indexPath.row)
            //print(idList)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "Segue", sender: self)
    }
    
    
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        list = DataBase.GetInstance().getTrainingTitle()
        self.tableView.reloadData()
    }
    
    @IBAction func addTraining(_ sender: UIBarButtonItem) {
        DataBase.GetInstance().insertEntrainement(vc: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //DataBase.GetInstance().listTraining()
    }
    
    
}

