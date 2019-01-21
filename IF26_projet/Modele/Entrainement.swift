//
//  Entrainement.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import Foundation

/**
 Objet représentant un entrainement
 @titre
 @key
 */
class Entrainement{
    
    private var titre:String
    private var key:Int

    init(titre:String, key:Int) {
        self.key = key
        self.titre = titre
       
    }
    
    func getTitle() -> String{
        return self.titre
    }
    
    func getKey() -> Int{
        return self.key
    }
}
