//
//  ExerciceTabViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 19/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit

var pets = ["dogs","cat","rabbit"]
var petDesc = ["Beautiful", "gikkd", "khfsndkfds"]

class ExerciceTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pets[indexPath.row]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FQDFEDSF?SDLFJSDL")
        
    }
    
    
    
    
}
