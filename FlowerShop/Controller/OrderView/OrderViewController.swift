//
//  OrderViewController.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/27/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    let totalPrice = TotalPrice.shared
    var indexCell = Int()
    
    @IBOutlet weak var orderCollectonView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPrice.orderArray.append(totalPrice.fullPrice = calculateTotalPrice(totalPrice.orderArray))
        
        setupOVC()
        style()
    }
    
    func setupOVC() {
        //register Cell
        //OrderFlowerCell
        orderCollectonView.register(UINib(nibName: "OrderFlowerCell", bundle: nil), forCellWithReuseIdentifier: "OrderFlowerCell")
        //OrderPackagCell
        orderCollectonView.register(UINib(nibName: "OrderPackagCell", bundle: nil), forCellWithReuseIdentifier: "OrderPackagCell")
        //OrderTotalCell
        orderCollectonView.register(UINib(nibName: "OrderTotalCell", bundle: nil), forCellWithReuseIdentifier: "OrderTotalCell")
    }
    
    func style() {
        let layout = orderCollectonView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width)
        layout.minimumLineSpacing = 30
        
        orderCollectonView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 300, right: 0)
    }
    
    func calculateTotalPrice(_ products: Array<Any>) -> Int {
        var sum = Int()
        for element in products.indices {
            if totalPrice.orderArray[element] is OrderFlower {
                let prod = totalPrice.orderArray[element] as? OrderFlower
                sum += prod?.price ?? 0
            } else {
                let prod = totalPrice.orderArray[element] as? OrderPackeg
                sum += prod?.price ?? 0
            }
        }
        return sum
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        totalPrice.orderArray.removeLast()
    }
    
    @IBAction func buyButton(_ sender: UIButton) {
    }
}

extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalPrice.orderArray.count
    }
    
    func removeProduct(_ indexPath: Int) {
        totalPrice.orderArray.remove(at: indexPath)
        totalPrice.fullPrice = calculateTotalPrice(totalPrice.orderArray)
        orderCollectonView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if totalPrice.orderArray[indexPath.item] is OrderFlower {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderFlowerCell", for: indexPath) as! OrderFlowerCell
            let flower = totalPrice.orderArray[indexPath.item] as! OrderFlower
            
            cell.flowerName.text = flower.name
            cell.imageFlower?.sd_setImage(with: URL(string: flower.image), completed: nil)
            cell.quantity.text = String(flower.quantity) + " шт."
            cell.price.text = String(flower.price) + " ₴"
            cell.size.text = String(flower.size)
            
            cell.callback = {
                self.removeProduct(indexPath.item)
            }
            
            return cell
        } else if totalPrice.orderArray[indexPath.item] is OrderPackeg {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderPackagCell", for: indexPath) as! OrderPackagCell
            let packege = totalPrice.orderArray[indexPath.item] as! OrderPackeg
            
            cell.nameLabel.text = packege.name
            cell.image.image = UIImage(named: packege.image)
            cell.price.text = String(packege.price) + " ₴"
            
            cell.callback = {
                self.removeProduct(indexPath.item)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderTotalCell", for: indexPath) as! OrderTotalCell
            
            cell.totalPrice.text = String(totalPrice.fullPrice) + " ₴"
            
            return cell
        }
    }
}
