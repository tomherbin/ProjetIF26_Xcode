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
    
    
    let exerciceTable = Table("exercice")
    let idExercice = Expression<Int>("idExo")
    let nameExercice = Expression<String>("titre")
    let description = Expression<String>("description")
    
     let programmeTable = Table("programme")
    let programmeExerciceId = Expression<Int>("idExoProg")
    
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
            
        }
        let createExerciceTable = self.exerciceTable.create { (table) in
            table.column(self.idExercice, primaryKey: true)
            table.column(self.nameExercice)
            table.column(self.description)
        }
        let createProgrammeTable = self.programmeTable.create { (table) in
            table.column(self.id)
            table.column(self.programmeExerciceId)
            
            table.primaryKey(self.id, self.programmeExerciceId)
            table.foreignKey(self.programmeExerciceId, references: exerciceTable, self.idExercice)
            table.foreignKey(self.id, references: trainingTable, self.id)
        }
        
        do {
            /*print("Suppression des tables si changement de structure");
            try self.database.run(trainingTable.drop(ifExists : true))
            try self.database.run(exerciceTable.drop(ifExists : true))
            try self.database.run(programmeTable.drop(ifExists : true))*/
            
            try self.database.run(createTrainingTable)
            try self.database.run(createExerciceTable)
            try self.database.run(createProgrammeTable)
            print("Created Table")
        } catch {
            print(error)
        }
    
    }
    
    
    public func insertEntrainement(vc: FirstViewController){
        
        let alert = UIAlertController(title: "Nouvel entrainement", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "titre" }
        
        let action = UIAlertAction(title: "Valider", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text
                else { return }
            print(name)
            
            let insertTraining = self.trainingTable.insert(self.name <- name)
            
            do {
                try self.database.run(insertTraining)
                print("Training inséré !")
                self.listTraining()
                vc.tableView.reloadData()
                vc.viewWillAppear(true)
            } catch {
                print(error)
            }
            
        }
        
        let action2 = UIAlertAction(title: "Annuler", style: .default)
        
        alert.addAction(action2)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    //Chargement de la banque d'exercice
    public func insertExercice(exercice : [Exercice]){
        
        for exerciceEntry in exercice {
            let insertExercice = self.exerciceTable.insert(self.nameExercice <- exerciceEntry.getTitle(), self.description <- exerciceEntry.getDescription(), self.idExercice <- exerciceEntry.getKey())
            print (insertExercice)
            do {
                try self.database.run(insertExercice)
                print("Exercice inséré !")
                self.listExercice()
            } catch {
                print(error)
            }
        }
        
        
    }
    
    //Boite de dialogue d'ajout d'exercice, plus utilisé
    public func insertExercice(vc: ExerciceTabViewController){
        
        let alert = UIAlertController(title: "Nouvel exercice", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "titre" }
        alert.addTextField { (tf) in tf.placeholder = "description" }
        
        let action = UIAlertAction(title: "Valider", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text, let description = alert.textFields?.last?.text
                else { return }
            print(name)
            print(description)
            let insertExercice = self.exerciceTable.insert(self.nameExercice <- name, self.description <- description)
            print (insertExercice)
            do {
                try self.database.run(insertExercice)
                print("Exercice inséré !")
                self.listExercice()
                vc.tableView.reloadData()
                vc.viewWillAppear(true)
            } catch {
                print(error)
            }
            
        }
        
        let action2 = UIAlertAction(title: "Annuler", style: .default)
        
        alert.addAction(action2)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    public func addTrainingExercice(trainingKey : Int, exerciceKey : Int){
        
        let insertExercice = self.programmeTable.insert(self.id <- trainingKey, self.programmeExerciceId <- exerciceKey)
            print (insertExercice)
            do {
                try self.database.run(insertExercice)
                print("Exercice ajouté à l'entrainement !")
           //     vc.tableView.reloadData()
            //    vc.viewWillAppear(true)
            } catch {
                print(error)
            }
            
        }
        
    
    
    public func listProgramme(){
        print("Affichage de la liste des programmes")
        
        do {
            let programme = try self.database.prepare(self.programmeTable)
            for programmeEntry in programme {
                print(" id: \(programmeEntry[self.id]), idExo: \(programmeEntry[self.programmeExerciceId])")
            }
        } catch {
            print(error)
        }
        
    }
    
    
    public func listExercice(){
        print("Affichage de la liste des exercices")
        
        do {
            let exercice = try self.database.prepare(self.exerciceTable)
            for exerciceEntry in exercice {
                print(" name: \(exerciceEntry[self.name]), idExo: \(exerciceEntry[self.idExercice])")
            }
        } catch {
            print(error)
        }
        
    }
    
   
    public func listTraining(){
        print("Affichage de la liste des entrainements")
        
        do {
            let training = try self.database.prepare(self.trainingTable)
            for trainingEntry in training {
                print("Id: \(trainingEntry[self.id]), name: \(trainingEntry[self.name]), ")
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
    
 /*   public func getExerciceKey(name : String) -> [String] {
        
        var ExerciceArray: [String] = []
        do {
            let Exercice = try self.database.prepare(self.ExerciceTable)
            for trainingEntry in Exercice {
                print("Id: \(trainingEntry[self.id]), name: \(trainingEntry[self.name]), idExo: \(trainingEntry[self.idExercice])")
                
                let trainingCell = "Id: \(trainingEntry[self.id]), name: \(trainingEntry[self.name]), idExo: \(trainingEntry[self.idExercice])"
                trainingArray.append(trainingCell)
            }
        } catch {
            print(error)
        }
        
        return trainingArray
        
    }*/
    
    public func getTrainingTitle() -> [String] {
        
        var trainingArray: [String] = []
        
        do {
            
            let training = try self.database.prepare(self.trainingTable)
            for trainingEntry in training {
                print("\(trainingEntry[self.name])")
                
                let trainingCell = "\(trainingEntry[self.name])"
                trainingArray.append(trainingCell)
            }
        } catch {
            print(error)
        }
        
        return trainingArray
        
    }
    
    public func getTrainingKey() -> [Int] {
        var TrainingKeyArray: [Int] = []
        
        do {
            
            let training = try self.database.prepare(self.trainingTable)
            for trainingEntry in training {
                let trainingCell: Int = trainingEntry[self.id]
                TrainingKeyArray.append(trainingCell)
            }
        } catch {
            print(error)
        }
        return TrainingKeyArray
    }
    
    public func  getExerciceDescription() -> [String]{
        var DescriptionArray: [String] = []
        
        do {
            
            let description = try self.database.prepare(self.exerciceTable)
            for descriptionEntry in description {
                let descriptionCell: String = descriptionEntry[self.description]
                DescriptionArray.append(descriptionCell)
            }
        } catch {
            print(error)
        }
        return DescriptionArray
    }
    
    
    public func getTrainingExercice() -> [String]{
        
        var exerciceArray: [String] = []
        
        do {
            
            let training = try self.database.prepare(self.exerciceTable)
            for exerciceEntry in training {
                print("\(exerciceEntry[self.nameExercice])")
                
                let exerciceCell = "\(exerciceEntry[self.nameExercice])"
                exerciceArray.append(exerciceCell)
            }
        } catch {
            print(error)
        }
        
        return exerciceArray
    }
    
    
    
    public func deleteTraining(trainingId : Int ) {

        let training = self.trainingTable.filter(self.id == trainingId)
        let deleteTraining = training.delete()
        do {
            try self.database.run(deleteTraining)
        } catch {
            print(error)
        }
        
    }
    
    
    public func deleteExercice(exerciceKey : Int ) {
        let exercice = self.exerciceTable.filter(self.idExercice == exerciceKey)
        let deleteExercice = exercice.delete()
        do {
            try self.database.run(deleteExercice)
        } catch {
            print(error)
        }
        
    }
    
    
    public func deleteProgramme(exerciceKey : Int, trainingKey : Int ) {
        let exercice = self.programmeTable.filter(self.programmeExerciceId == exerciceKey).filter(self.id == trainingKey)
        let deleteExercice = exercice.delete()
        do {
            try self.database.run(deleteExercice)
        } catch {
            print(error)
        }
        
    }
    
    
    public func getExercice() -> [Exercice]{
        var exerciceArray: [Exercice] = []
        
        do{
            let exercice = try self.database.prepare(self.exerciceTable)
            for exerciceEntry in exercice {
                let exerciceLigne = Exercice(exerciceKey: exerciceEntry[idExercice], titre: exerciceEntry[name], description: exerciceEntry[description])
                
                
                exerciceArray.append(exerciceLigne)
            }
        }
        catch {
            print(error)
        }
        
        return exerciceArray
    }
    
    /*Thread 1: Fatal error: 'try!' expression unexpectedly raised an error: Ambiguous column `"idExo"` (please disambiguate: ["\"exercice\".\"idExo\"", "\"programme\".\"idExo\""])*/
    
    //Récupérer les exercices d'un entrainement avec une jointure
    public func getExerciceFromTraining(key: Int) -> [Exercice]{
            
            var exerciceArray: [Exercice] = []
            let selectExercice = programmeTable.join(exerciceTable, on: id == key && programmeExerciceId == idExercice)
        print("----")
        print(selectExercice)
            do {
                for exerciceEntry in  try database.prepare(selectExercice) {
                    
                    let exerciceLigne = Exercice(exerciceKey: exerciceEntry[idExercice], titre: exerciceEntry[name], description: exerciceEntry[description])
                    
                    exerciceArray.append(exerciceLigne)
                }
            }catch {
                print(error)
            }
            return exerciceArray
        }
    
    
    
    
    public func getTraining() -> [Entrainement]{
        var trainingArray: [Entrainement] = []
        
        do{
            let training = try self.database.prepare(self.trainingTable)
            for trainingEntry in training {
                let trainingLigne = Entrainement(titre: trainingEntry[name], key: trainingEntry[id])
                
                print(trainingLigne)
                trainingArray.append(trainingLigne)
            }
        }
        catch {
            print(error)
        }
        
        return trainingArray
    }
    
    
    
}
