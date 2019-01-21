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
    /**
     Variable de connection à la base de donnée et description des tables
     
     */
    private static var dataBaseInstance: DataBase?
    private var database: Connection!
    
    let trainingTable = Table("entrainement")
    let id = Expression<Int>("id")
    let name = Expression<String>("titre")
    
    
    let exerciceTable = Table("exercice")
    let idExercice = Expression<Int>("idExo")
    let nameExercice = Expression<String>("titre")
    let description = Expression<String>("description")
    let reps = Expression<Int>("reps")
    let serie = Expression<Int>("serie")
    
    let programmeTable = Table("programme")
    let programmeExerciceId = Expression<Int>("idExoProg")
    
    /**
     Implantation du patron de conception Singleton pour n'avoir qu'une seule instance de base de donnée à la fois
     */
    static func GetInstance()->DataBase{
        
        if(dataBaseInstance == nil){
            dataBaseInstance = DataBase()
        }
        
        return dataBaseInstance!
    }
    
    /**
     Connection de la base de donnée
     */
    private init() {
        
        do
        {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("data_base").appendingPathExtension("sqlite3")
            let base = try Connection(fileUrl.path)
            self.database = base;
            //Doesn't work ->Activation du mode cascade des clés étrangères
            /*
             let db = try Connection(fileUrl.path)
             try db.execute("PRAGMA foreign_keys = ON;") // turns on foreign keys support for the db connection
             */
        }
        catch
        {
            print (error)
        }
        
        /**
         Création des 3 tables : Entrainement, Exercice et programme
         */
        let createTrainingTable = self.trainingTable.create(ifNotExists: true) { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            
        }
        let createExerciceTable = self.exerciceTable.create(ifNotExists: true) { (table) in
            table.column(self.idExercice, primaryKey: true)
            table.column(self.nameExercice)
            table.column(self.description)
            table.column(self.reps)
            table.column(self.serie)
        }
        let createProgrammeTable = self.programmeTable.create(ifNotExists: true) { (table) in
            table.column(self.id)
            table.column(self.programmeExerciceId)
            table.primaryKey(self.id, self.programmeExerciceId)
            table.foreignKey(self.programmeExerciceId, references: exerciceTable, self.idExercice, delete:.cascade)
            table.foreignKey(self.id, references: trainingTable, self.id, delete:.cascade)
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
    
    /**
     Insérer un entrainement dans sa table
     
     Boite de dialogue permettant d'entrer son titre
     */
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
    
    /**
     Chargement de la banque d'exercice avec les données de la classe BanqueExercice
     */
    public func insertExercice(exercice : [Exercice]){
        
        for exerciceEntry in exercice {
            let insertExercice = self.exerciceTable.insert(self.nameExercice <- exerciceEntry.getTitle(), self.description <- exerciceEntry.getDescription(), self.idExercice <- exerciceEntry.getKey(), self.reps <- exerciceEntry.getRepetition(), self.serie <- exerciceEntry.getSerie())
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
    /**
     Ajout des correspondance Exercice.Entrainement dans la table programme
     @param clé d'entrainement
     @param clé d'exercice
     */
    public func addTrainingExercice(trainingKey : Int, exerciceKey : Int){
        
        let insertExercice = self.programmeTable.insert(self.id <- trainingKey, self.programmeExerciceId <- exerciceKey)
        print (insertExercice)
        do {
            try self.database.run(insertExercice)
            print("Exercice ajouté à l'entrainement !")
        } catch {
            print(error)
        }
        
    }
    
    /**
     Affichage de la liste des programmes dans la console
     */
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
    /**
     Affichage de la liste des exercices dans la console
     */
    
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
    
    /**
     Affichage de la liste des entrainements dans la console
     */
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
    /**
     Supprimer un entrainement
     
     @param id de l'entrainement
     */
    
    public func deleteTraining(trainingId : Int ) {
        
        let training = self.trainingTable.filter(self.id == trainingId)
        self.deleteProgramme(trainingKey: trainingId)
        
        
        let deleteTraining = training.delete()
        
        do {
            try self.database.run(deleteTraining)
            
        } catch {
            print(error)
        }
        
    }
    /**
     Supprimer un exercice
     
     @param id de l'exercice
     */
    
    public func deleteExercice(exerciceKey : Int ) {
        let exercice = self.exerciceTable.filter(self.idExercice == exerciceKey)
        let deleteExercice = exercice.delete()
        do {
            try self.database.run(deleteExercice)
        } catch {
            print(error)
        }
        
    }
    
    /**
     Supprimer les exercices d'un entrainement
     
     @param id de l'entrainement
     */
    public func deleteProgramme(trainingKey : Int ) {
        let programme = self.programmeTable.filter(self.id == trainingKey)
        let deleteProgramme = programme.delete()
        do {
            try self.database.run(deleteProgramme)
        } catch {
            print(error)
        }
        
    }
    /**
     Supprimer une entrée de l'entrainement
     
     @param id de l'entrainement
     @param id de l'exo
     */
    public func deleteProgramme(exerciceKey : Int, trainingKey : Int ) {
        let exercice = self.programmeTable.filter(self.programmeExerciceId == exerciceKey).filter(self.id == trainingKey)
        let deleteExercice = exercice.delete()
        do {
            try self.database.run(deleteExercice)
        } catch {
            print(error)
        }
        
    }
    /**
     Renvoie le tableau des exercices de la bdd
     */
    
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
    
    /**
     Récupérer les exercices d'un entrainement avec une jointure
     @param id de l'entrainement
     @return tableau d'exercice
     */
    
    public func getExerciceFromTraining(key: Int) -> [Exercice]{
        
        var exerciceArray: [Exercice] = []
        let selectExercice = programmeTable.join(exerciceTable, on: id == key && programmeExerciceId == idExercice)
        do {
            for exerciceEntry in  try database.prepare(selectExercice) {
                
                let exerciceLigne = Exercice(exerciceKey: exerciceEntry[idExercice],reps: exerciceEntry[reps], serie: exerciceEntry[serie], titre: exerciceEntry[name], description: exerciceEntry[description])
                
                exerciceArray.append(exerciceLigne)
            }
        }catch {
            print(error)
        }
        return exerciceArray
    }
    
    /**
     Récupérer les entrainements
     @return tableau d'entrainement
     */
    
    public func getTraining() -> [Entrainement]{
        var trainingArray: [Entrainement] = []
        
        do{
            let training = try self.database.prepare(self.trainingTable)
            for trainingEntry in training {
                let trainingLigne = Entrainement(titre: trainingEntry[name], key: trainingEntry[id])
                trainingArray.append(trainingLigne)
            }
        }
        catch {
            print(error)
        }
        
        return trainingArray
    }
    
    
    
}
