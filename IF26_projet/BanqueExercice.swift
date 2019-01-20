//
//  BanqueExercice.swift
//  IF26_projet
//
//  Created by Tom Hache on 20/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import Foundation



class BanqueExercice {
    
   private var exercice : [Exercice] = []
    private static var banqueExerciceInstance : BanqueExercice?
    
    static func GetInstance()->BanqueExercice{
        
        if(banqueExerciceInstance == nil){
            banqueExerciceInstance = BanqueExercice()
        }
        
        return banqueExerciceInstance!
    }
    
    init()
    {
        exercice.append(Exercice.init(exerciceKey: 1, reps: 8, serie: 4, titre: "Tractions", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 2, reps: 8, serie: 4, titre: "DC", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 3, reps: 8, serie: 4, titre: "Butterfly", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 4, reps: 8, serie: 4, titre: "Abdos", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 5, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 6, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 7, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 8, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        DataBase.GetInstance().insertExercice(exercice : exercice)
    }
    
}
