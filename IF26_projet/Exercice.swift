//
//  Exercice.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import Foundation

class Exercice{
    
    private var titre:String
    private var reps:Int
    private var serie:Int
    private var exerciceKey:Int
    
    
    init(exerciceKey:Int, reps:Int,serie:Int, titre:String){
        self.exerciceKey = exerciceKey
        self.reps = reps
        self.serie = serie
        self.titre = titre
    }
    
    
}
