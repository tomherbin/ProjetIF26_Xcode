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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var list = DataBase.GetInstance().getTrainingString()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        list = DataBase.GetInstance().getTrainingString()
        self.tableView.reloadData()
    }
    
    
    @IBAction func addTraining(_ sender: UIButton) {
        print("lol1")
        DataBase.GetInstance().insertEntrainement(vc: self)
        print("lo2")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataBase.GetInstance().listTraining()
    }
    
    func setSelected(_ selected: Bool, animated: Bool) {
        setSelected(selected, animated: animated)
        
    }
    
}

