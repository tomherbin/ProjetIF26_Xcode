//
//  SecondViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit
/**
Controller de la partie rechercher des amis
 CollectionView (tableau)
 
 */
class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
   
    @IBOutlet weak var table: UICollectionView!
    var arrayFriends : [Friends] = []
    var currentFriends : [Friends] = []
    
    /**
 Calcul du nombre de cellule à afficher dans la vue
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentFriends.count
    }
    /**
     Chargement des cellules une à une
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath) as! FriendsCollectionViewCell
        cell.test?.text = currentFriends[indexPath.row].getName()
        cell.myImageView?.image = UIImage(named: (currentFriends[indexPath.row].getName() + ".jpg"))
        return (cell)
    }
    /**
     Gestion de la searchBar
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { currentFriends = arrayFriends
            table.reloadData()
            return }
        
        currentFriends = arrayFriends.filter({ (friends) -> Bool in
            friends.name.contains(searchText)
        })
        table.reloadData()
    }
    /**
     Cacher le clavier lorsque qu'on déplace la collectionView
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !table.isDecelerating {
            view.endEditing(true)
        }
        view.endEditing(true)
    }
    /**
     Cacher le clavier lorsque qu'on touche return
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         view.endEditing(true)
        return true
    }
    /**
     Création des objets friends et ajout au tableau pour simuler l'affichage
     */
    func setupFriends(){
        arrayFriends.append(Friends(name: "Marc"))
        arrayFriends.append(Friends(name: "Henri"))
        arrayFriends.append(Friends(name: "Julien"))
        arrayFriends.append(Friends(name: "Franck"))
        arrayFriends.append(Friends(name: "Tom"))
        arrayFriends.append(Friends(name: "Jean"))
        arrayFriends.append(Friends(name: "Louis"))
        arrayFriends.append(Friends(name: "Loic"))
        arrayFriends.append(Friends(name: "Damien"))
        arrayFriends.append(Friends(name: "Jeanne"))
        arrayFriends.append(Friends(name: "Moise"))
        
    }
  
    /**
     Chargement de la vue
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFriends()
       currentFriends = arrayFriends
    }
}

/**
 Objet Friends
 Création des objets amis
 
 */
class Friends {
    let name : String
    
    init(name: String) {
        self.name = name
        
    }
    
    func getName() -> String{
        return self.name
    }
    
}
