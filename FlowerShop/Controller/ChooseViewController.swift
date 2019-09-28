//
//  ChooseViewController.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/16/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {

    let totalPrice = TotalPrice.shared
    
    var getImege = String()
    var getName = String()
    var getDescription = String()
    var getPrice = Int()
    
    var totalQuantity = 1
    var sizeFlower = "Маленький"
    var countPrice = Int()
    
    @IBOutlet weak var imageFlowerChoose: UIImageView!
    @IBOutlet weak var backgraundImegeFlower: UIView!
    @IBOutlet weak var descriptionFlower: UITextView!
    @IBOutlet weak var nameFlower: UILabel!
    @IBOutlet weak var backgraundView: UIView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceAndNextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
    }
    
    func setup() {
        countPrice = getPrice
        priceAndNextButton.setTitle("Цена \(getPrice) ₴", for: .normal)
        
        imageFlowerChoose.sd_setImage(with: URL(string: getImege), completed: nil)
        descriptionFlower.text = getDescription
        nameFlower.text = getName
    }
    
    func style() {
        //rounded image on ChooseViewController
        imageFlowerChoose?.layer.cornerRadius = imageFlowerChoose.frame.size.height / 2
        
        //shadow for backgraundView
        backgraundView.layer.cornerRadius = 10
        backgraundView.layer.shadowColor = UIColor.gray.cgColor
        backgraundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgraundView.layer.shadowRadius = 5.0
        backgraundView.layer.shadowOpacity = 0.5
        backgraundView.layer.masksToBounds = false
        
        //backgraund shadows image
        backgraundImegeFlower.layer.cornerRadius = imageFlowerChoose.frame.size.width / 2
        backgraundImegeFlower.layer.shadowColor = UIColor.gray.cgColor
        backgraundImegeFlower.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgraundImegeFlower.layer.shadowRadius = 5.0
        backgraundImegeFlower.layer.shadowOpacity = 0.5
        backgraundImegeFlower.layer.masksToBounds = false
        
        // button design
        priceAndNextButton.layer.cornerRadius = priceAndNextButton.frame.size.height / 2
        priceAndNextButton.layer.shadowColor = UIColor.gray.cgColor
        priceAndNextButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        priceAndNextButton.layer.shadowRadius = 5.0
        priceAndNextButton.layer.shadowOpacity = 0.5
        priceAndNextButton.layer.masksToBounds = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let packagVC = segue.destination as! PackagingViewController
        packagVC.getPriceFlovers = countPrice
    }
    
    func addElemetInArray() {
        totalPrice.orderArray.append(OrderFlower(image: getImege,
                                                 name: getName,
                                                 price: countPrice,
                                                 size: sizeFlower,
                                                 quantity: totalQuantity))
    }
    
    @IBAction func changeCount(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        quantityLabel.text = "\(currentValue)"
        countPrice = currentValue * getPrice
        totalQuantity = currentValue
        priceAndNextButton.setTitle("Цена \(countPrice) ₴", for: .normal)
    }
    
    @IBAction func sizeFlowerButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            sizeFlower = "Маленький"
        case 1:
            sizeFlower = "Средний"
        case 2:
            sizeFlower = "Большой"
        default:
            return
        }
        
        print(sizeFlower)
    }
    
    func goToOrderForAlert() {
        let orderVC = storyboard?.instantiateViewController(withIdentifier: "OrderSID") as! OrderViewController
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Цветок уже есть в корзине!", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { (alert) in
            self.navigationController?.popViewController(animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "Перейти в корзину", style: .default, handler: { (alert) in
            self.goToOrderForAlert()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func checkFlowersInOrderArry() -> Bool {
        var state = true
        for element in totalPrice.orderArray.indices {
            if totalPrice.orderArray[element] is OrderFlower {
                let order = totalPrice.orderArray[element] as? OrderFlower
                if order?.name == getName {
                    state = true
                    break
                } else {
                    state = false
                }
            }
        }
        return state
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if totalPrice.orderArray.isEmpty {
            addElemetInArray()
        } else if checkFlowersInOrderArry() {
            showAlert()
        } else {
            addElemetInArray()
        }
    }
}

