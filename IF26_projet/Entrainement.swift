//
//  Entrainement.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import Foundation


class Entrainement{
    
    private var titre:String
    private var key:Int
    private var array = [Exercice]()
    
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
