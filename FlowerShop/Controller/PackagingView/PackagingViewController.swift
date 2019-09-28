//
//  PackagingViewController.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/27/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class PackagingViewController: UIViewController {
   
    let totalPrice = TotalPrice.shared
    
    var getPriceFlovers = Int()
    var calcPackege = Int()

    let dataCell = [OrderPackeg(name: "Дизайнерская упаковка",
                                description: "Роскошная коробка - это высококачественное упаковочное решение, которое                                                                           сохранит букет в безопасности.",
                                image: "Box",
                                price: 75),
                    OrderPackeg(name: "Оберточная бумага",
                                description: "Оберточная бумага - качественный вариант упаковки для использования в любом                                                       случае.",
                                image: "Wrapping Paper",
                                price: 20),
                    OrderPackeg(name: "Бант из ленты",
                                description: "Романтичный и оригинальный штрих с лентами.",
                                image: "Rectangle",
                                price: 30)]
    
    @IBOutlet weak var packegeCollectionView: UICollectionView!
    @IBOutlet weak var totalPriceButtonAndNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        style()
    }
    
    func setup() {
        //Multiple Selection
        packegeCollectionView?.allowsMultipleSelection = true
        
        //register Cell
        let nibCell = UINib(nibName: "PackagCell", bundle: nil)
        packegeCollectionView.register(nibCell, forCellWithReuseIdentifier: "PackagCell")
    }
    
    func style() {
        // size Cell
        let layout = packegeCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 135)
        layout.minimumLineSpacing = 30
        
        // button design
        totalPriceButtonAndNext.layer.cornerRadius = totalPriceButtonAndNext.frame.size.height / 2
        totalPriceButtonAndNext.layer.shadowColor = UIColor.gray.cgColor
        totalPriceButtonAndNext.layer.shadowOffset = CGSize(width: 0, height: 3)
        totalPriceButtonAndNext.layer.shadowRadius = 5.0
        totalPriceButtonAndNext.layer.shadowOpacity = 0.5
        totalPriceButtonAndNext.layer.masksToBounds = false
        
        totalPriceButtonAndNext.setTitle("Цена \(getPriceFlovers) ₴", for: .normal)
    }
}

extension PackagingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PackagCell", for: indexPath) as! PackagCell
        
        let dataForCell = dataCell[indexPath.item]
        
        cell.name.text = dataForCell.name
        cell.descriptionPackag.text = dataForCell.description
        cell.image.image = UIImage(named: dataForCell.image)
        cell.price.text = String(dataForCell.price) + " ₴"
        
        return cell
    }
}

extension PackagingViewController: UICollectionViewDelegate {
    func showAlert() {
        let alert = UIAlertController.init(title: "Test", message: "Test", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! PackagCell
        
        for item in totalPrice.orderArray.indices {
            if totalPrice.orderArray[item] is OrderPackeg {
                let checkElement = totalPrice.orderArray[item] as! OrderPackeg
                
                if checkElement.description == cell.description {
                     print("test selected element", checkElement)
                    showAlert()
                }
            }
        }
        
        cell.backgraundView.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.imageSelect.isHidden = false
        cell.imageSelect.image = UIImage(named: "select")
        
        calcPackege += dataCell[indexPath.item].price
        totalPriceButtonAndNext.setTitle("Цена \(getPriceFlovers + calcPackege) ₴", for: .normal)
        
        totalPrice.orderArray.append(dataCell[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PackagCell
        
        var imageNameForRemove = String()
        imageNameForRemove = dataCell[indexPath.item].image
        
        cell.backgraundView.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.imageSelect.isHidden = true
        
        calcPackege -= dataCell[indexPath.item].price
        totalPriceButtonAndNext.setTitle("Цена \(getPriceFlovers - calcPackege) ₴", for: .normal)
        
        // remove packege with array
        if !(totalPrice.orderArray.isEmpty) {
            totalPrice.orderArray.remove(at: {
                var index = Int()
                for element in totalPrice.orderArray.indices {
                    if totalPrice.orderArray[element] is OrderPackeg {
                        let order = totalPrice.orderArray[element] as! OrderPackeg
                        if order.image == imageNameForRemove {
                            index = element
                        }
                    }
                }
                return index
            }())
        }
    }
}
