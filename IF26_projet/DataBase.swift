//
//  DataBase.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import Foundation
import SQLite
import UIKit

class DataBase {
    
    private static var dataBaseInstance: DataBase?
    private var database: Connection!
    
    let trainingTable = Table("entrainement")
    let id = Expression<Int>("id")
    let name = Expression<String>("titre")
  
    
    let exerciceTable = Table("entrainement")
    let idExercice = Expression<Int>("idExo")
    let nameExercice = Expression<String>("titre")
    
    
    static func GetInstance()->DataBase{
        
        if(dataBaseInstance == nil){
            dataBaseInstance = DataBase()
        }
        
        return dataBaseInstance!
    }
    
    
    private init() {
        
        do
        {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("data_base").appendingPathExtension("sqlite3")
            let base = try Connection(fileUrl.path)
            self.database = base;
        }
        catch
        {
            print (error)
        }
        
        
        let createTrainingTable = self.trainingTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.idExercice)
           
        }
        let createExerciceTable = self.exerciceTable.create { (table) in
            table.column(self.idExercice, primaryKey: true)
            table.column(self.name)
            
        }
        
        do {
            /*print("Suppression des tables si changement de structure");
            try self.database.run(trainingTable.drop(ifExists : true))
            try self.database.run(exerciceTable.drop(ifExists : true))*/
            
            try self.database.run(createTrainingTable)
            try self.database.run(createExerciceTable)
            print("Created Table")
        } catch {
            print(error)
        }
        
        
    }
    
    
    public func insertEntrainement(vc: FirstViewController, tableView: UITableView){
    print("Entrée de l'entrainement")
        
        
        print("INSERT TAPPED")
        let alert = UIAlertController(title: "Nouvel entrainement", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "titre" }
      
        let action = UIAlertAction(title: "Valider", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text
                else { return }
            print(name)
            
            let insertTraining = self.trainingTable.insert(self.name <- name, self.idExercice <- 0)
            
            do {
                try self.database.run(insertTraining)
                print("Training inséré !")
                
            } catch {
                print(error)
            }
            
        }
        
        let action2 = UIAlertAction(title: "Annuler", style: .default)
            
        alert.addAction(action2)
            alert.addAction(action)
       vc.present(alert, animated: true, completion: nil)
      
        
    }
    
    
    public func listTraining(){
        print("Affichage de la liste")
        
        do {
            let training = try self.database.prepare(self.trainingTable)
            for trainingEntry in training {
                print("Id: \(trainingEntry[self.id]), name: \(trainingEntry[self.name]), idExo: \(trainingEntry[self.idExercice])")
            }
        } catch {
            print(error)
        }
        
    }
    
    public func getTrainingString() -> [String] {
        
        var trainingArray: [String] = []
        
        do {
            
            let training = try self.database.prepare(self.trainingTable)
            for trainingEntry in training {
                print("Id: \(trainingEntry[self.id]), name: \(trainingEntry[self.name]), idExo: \(trainingEntry[self.idExercice])")
                
                let trainingCell = "Id: \(trainingEntry[self.id]), name: \(trainingEntry[self.name]), idExo: \(trainingEntry[self.idExercice])"
                trainingArray.append(trainingCell)
            }
        } catch {
            print(error)
        }
      
        return trainingArray
      
    }
      
    
}
