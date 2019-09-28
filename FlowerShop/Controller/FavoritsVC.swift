//
//  FavoritsTVC.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/23/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class FavoritsVC: UIViewController {
    
    var favoriteFlovers: [ItemFlower] = []
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if favoriteFlovers.count > 0 {
            infoLabel.text = ""
        } else {
            infoLabel.text = "Ваш список избранного пока-что пуст"
        }
        
        setup()
        style()
    }
    
    func setup() {
        //register Cell
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        favoriteCollectionView.register(nibCell, forCellWithReuseIdentifier: "Cell")
    }
    
    func style() {
        //size Cell
        let layout = favoriteCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 120)
        layout.minimumLineSpacing = 30
    }
}

extension FavoritsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteFlovers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let favoriteDisplayItem = favoriteFlovers[indexPath.item]
        
        cell.nameFlower?.text = favoriteDisplayItem.nameFlower
        cell.deskriptionFlower?.text = favoriteDisplayItem.description
        cell.imageFlower.sd_setImage(with: URL(string: favoriteDisplayItem.urlImage!), completed: nil)
        
        print(favoriteDisplayItem.nameFlower!)
        
        return cell
    }
}
