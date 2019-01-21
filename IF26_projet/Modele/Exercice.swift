//
//  Exercice.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import Foundation
/**
 Objet représentant un exercice
 @titre
 @reps
 @serie
 @exerciceKey
 @description
 */
class Exercice{
    
    private var titre:String
    private var reps:Int
    private var serie:Int
    private var exerciceKey:Int
    private var description:String
    
    init(exerciceKey:Int, reps:Int,serie:Int, titre:String, description:String){
        self.exerciceKey = exerciceKey
        self.reps = reps
        self.serie = serie
        self.titre = titre
        self.description = description
    }
    
    init(exerciceKey:Int, titre:String, description:String){
        self.exerciceKey = exerciceKey
        self.titre = titre
        self.description = description
        self.reps = 0
        self.serie = 0
    }
    
   
    func getTitle() -> String{
        return self.titre
    }
    
    func getSerie() -> Int{
        return self.serie
    }
    
    func getRepetition() -> Int{
        return self.reps
    }
    
    func getDescription() -> String{
        return self.description
    }
    
    func getKey() -> Int{
        return self.exerciceKey
    }
    
    
}
