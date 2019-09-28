//
//  ViewController.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/16/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit
import SDWebImage

struct MainButton {
    let name: String
    let color: UIColor
}

class ViewController: UIViewController {
    
    var flowers: [ItemFlower] = []
    var bestsellers: [ItemFlower] = []
    var bouquets: [ItemFlower] = []
    var presents: [ItemFlower] = []
    var set: [ItemFlower] = []
    
    let listOfGoods = [MainButton(name: "Цветы🌺", color: #colorLiteral(red: 0.9948144555, green: 0.7565326095, blue: 0.05473177135, alpha: 1)),
                       MainButton(name: "Букеты💐", color: #colorLiteral(red: 0.9948144555, green: 0.7565326095, blue: 0.05473177135, alpha: 1)),
                       MainButton(name: "Подарки🎉", color: #colorLiteral(red: 0.9948144555, green: 0.7565326095, blue: 0.05473177135, alpha: 1)),
                       MainButton(name: "Наборы🎁", color: #colorLiteral(red: 0.9948144555, green: 0.7565326095, blue: 0.05473177135, alpha: 1))]
    
    @IBOutlet weak var listButtonCVC: UICollectionView!
    @IBOutlet weak var previewOfGoodsCVC: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProductList()
        
        setup()
        style()
    }
    
    func setup() {
        listButtonCVC.delegate = self
        listButtonCVC.dataSource = self
        
        previewOfGoodsCVC.delegate = self
        previewOfGoodsCVC.dataSource = self
    }
    
    func style() {
        //clear color navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func loadProductList() {
        NetworkServices.loadJSONData { [unowned self] (products, error) in
            DispatchQueue.main.async {
                if let flowerProduct = products?.flowers {
                    self.flowers = flowerProduct
                }
                if let bestsellerProduct = products?.bestsellers {
                    self.bestsellers = bestsellerProduct
                }
                if let bouquetsProduct = products?.bouquets {
                    self.bouquets = bouquetsProduct
                }
                if let presentsProduct = products?.presents {
                    self.presents = presentsProduct
                }
                if let setProduct = products?.set {
                    self.set = setProduct
                }
                
                self.previewOfGoodsCVC.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == listButtonCVC {
            return listOfGoods.count
        } else {
            return bestsellers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == listButtonCVC {
            let cell: CellForListOfGoods = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForListOfGoods", for: indexPath) as! CellForListOfGoods
            let dataForCell = listOfGoods[indexPath.item]
            
            cell.labelText.text = dataForCell.name
            cell.backgroundColor = dataForCell.color
            
            return cell
        } else {
            let cell: CellForReviewItem = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForReviewItem", for: indexPath) as! CellForReviewItem
            let dataForCell = bestsellers[indexPath.item]
            
            cell.textLabel.text = String(dataForCell.price!) + " ₴"
            cell.imageFlower?.sd_setImage(with: URL(string: dataForCell.urlImage!), completed: nil)
            
            return cell
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == listButtonCVC {
            let dataList = listOfGoods[indexPath.item].name
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "CollectionVCSID") as! CollectionVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            switch dataList {
            case "Цветы🌺":
                vc.flowers = flowers
                vc.getTitleForLabel = "Цветы🌺"
            case "Букеты💐":
                vc.flowers = bouquets
                vc.getTitleForLabel = "Букеты💐"
            case "Подарки🎉":
                vc.flowers = presents
                vc.getTitleForLabel = "Подарки🎉"
            case "Наборы🎁":
                vc.flowers = set
                vc.getTitleForLabel = "Наборы🎁"
            default:
                return
            }
        } else {
            let dataForDescription = bestsellers[indexPath.item]
            let deskript = storyboard?.instantiateViewController(withIdentifier: "ChooseVCSID") as! ChooseViewController
            self.navigationController?.pushViewController(deskript, animated: true)
            
            deskript.getImege = dataForDescription.urlImage!
            deskript.getName = dataForDescription.nameFlower!
            deskript.getPrice = dataForDescription.price!
            deskript.getDescription = dataForDescription.description!
        }
    }
}
