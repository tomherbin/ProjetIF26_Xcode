//
//  FirstViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit
import SQLite

class FirstViewController: UIViewController {

    private var database: Connection!
    
    let usersTable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    
    
    
    
    @IBAction func ajouter(_ sender: UIButton) {
        
        print("LOl");
        
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.email, unique: true)
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("data_base").appendingPathExtension("sqlite3")
            let base = try Connection(fileUrl.path)
            self.database = base;

        }catch{
            print(error)
        }
        
    }


}

