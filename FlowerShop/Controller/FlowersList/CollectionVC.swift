//
//  CollectionVC.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/16/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    var getTitleForLabel = String()
    var flowers: [ItemFlower] = []
    var favoriteFlowers: [ItemFlower] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
    }
    
    func setup() {
        //register Cell
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "Cell")
        
        titleTextLabel.text = getTitleForLabel
    }
    
    func style() {
        //size Cell
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 120)
        layout.minimumLineSpacing = 30
        
        //space collectionView
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
    }
}

extension CollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flowers.count
    }
    
    @objc @IBAction func likeButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview?.superview as? UICollectionViewCell {
            if let indexPath = collectionView.indexPath(for: cell) {
                let favoriteItem = flowers[indexPath.item]
                
                if let index = favoriteFlowers.firstIndex(where: { (flover) -> Bool in
                    favoriteItem.nameFlower == flover.nameFlower
                }) {
                    favoriteFlowers.remove(at: index)
                } else {
                    favoriteFlowers.append(favoriteItem)
                }
                collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let itemToDisplay = flowers[indexPath.item]
        
        cell.likeButton.addTarget(self, action: #selector(likeButton(_:)), for: .touchUpInside)
        
        if let _ = favoriteFlowers.firstIndex(where: { (flover) -> Bool in
            itemToDisplay.nameFlower == flover.nameFlower
        })
        {
            cell.likeButton.setImage(UIImage(named: "heart_yellow"), for: UIControl.State.normal)
        }
        else {
            cell.likeButton.setImage(UIImage(named: "heart_grey"), for: UIControl.State.normal)
        }
        DispatchQueue.main.async {
            cell.imageFlower.sd_setImage(with: URL(string: itemToDisplay.urlImage!), completed: nil)
        }
        cell.getImageURL = itemToDisplay.urlImage!
        
        cell.nameFlower?.text = itemToDisplay.nameFlower
        cell.deskriptionFlower.text = itemToDisplay.description
        if let converToString = itemToDisplay.price {
            let convert = String(converToString)
            cell.priceFlower.text =  convert + " ₴"
        }
        
        return cell
    }
}

extension CollectionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionVC = storyboard?.instantiateViewController(withIdentifier: "ChooseVCSID") as! ChooseViewController
        self.navigationController?.pushViewController(collectionVC, animated: true)
        
        let flover = flowers[indexPath.row]
        
        // transfer information on ChooseViewController
        collectionVC.getDescription = flover.description!
        collectionVC.getName = flover.nameFlower!
        collectionVC.getImege = flover.urlImage!
        collectionVC.getPrice = flover.price!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let favoriteVC = segue.destination as! FavoritsVC
            favoriteVC.favoriteFlovers = favoriteFlowers
    }
}
