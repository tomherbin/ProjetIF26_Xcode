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
        exercice.append(Exercice.init(exerciceKey: 1, reps: 8, serie: 4, titre: "Tractions", description: "La traction est un exercice physique consistant à hisser ses épaules au niveau d'une barre en la tenant par les mains. Les tractions ont pour objectif principal le développement des muscles du dos et des bras"))
        exercice.append(Exercice.init(exerciceKey: 2, reps: 8, serie: 4, titre: "DC", description: "Le développé couché est un exercice poly-articulaire de force et de musculation qui consiste à soulever et abaisser une barre d'haltères, développant principalement les pectoraux."))
        exercice.append(Exercice.init(exerciceKey: 3, reps: 8, serie: 4, titre: "Butterfly", description: "Le pec deck ou butterfly est un exercice de musculation ciblant les pectoraux."))
        exercice.append(Exercice.init(exerciceKey: 4, reps: 8, serie: 4, titre: "Abdos", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 5, reps: 8, serie: 4, titre: "Gainage", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 6, reps: 8, serie: 4, titre: "Curl Biceps", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 7, reps: 8, serie: 4, titre: "Curls Legs", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 8, reps: 8, serie: 4, titre: "Extension Triceps", description: "Allonger vous sur le ventre et poussez avec les bras"))
        exercice.append(Exercice.init(exerciceKey: 9, reps: 8, serie: 4, titre: "Pompes", description: "Allonger vous sur le ventre et poussez avec les bras"))
        DataBase.GetInstance().insertExercice(exercice : exercice)
    }
    
}
