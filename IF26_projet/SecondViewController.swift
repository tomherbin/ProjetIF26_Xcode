//
//  SecondViewController.swift
//  IF26_projet
//
//  Created by Tom Hache on 18/01/2019.
//  Copyright © 2019 Tom Herbin TH. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
   
    
  
    @IBOutlet weak var table: UICollectionView!
    //  var friends : [Friends] = []
    let friends = ["Henri", "Leon", "Marc","Henri", "Leon", "Marc","Henri", "Leon", "Marc","Henri", "Leon", "Marc"]
    
    var arrayFriends : [Friends] = []
    var currentFriends : [Friends] = []
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentFriends.count
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCollection", for: indexPath) as! FriendsCollectionViewCell
     
        cell.test?.text = currentFriends[indexPath.row].getName()
        cell.myImageView?.image = UIImage(named: (currentFriends[indexPath.row].getName() + ".jpg"))
        
        return (cell)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { currentFriends = arrayFriends
            table.reloadData()
            return }
        
        currentFriends = arrayFriends.filter({ (friends) -> Bool in
            friends.name.contains(searchText)
        })
        table.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !table.isDecelerating {
            view.endEditing(true)
        }
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         view.endEditing(true)
        return true
    }
    
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
  

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFriends()
       currentFriends = arrayFriends
    }


}


class Friends {
    let name : String
    
    init(name: String) {
        self.name = name
        
    }
    
    func getName() -> String{
        return self.name
    }
    
}
