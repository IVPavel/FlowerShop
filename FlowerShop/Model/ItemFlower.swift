//
//  Flower.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/16/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

class ListFlower: Codable {
    var flowers: [ItemFlower]
    var bestsellers: [ItemFlower]
    var bouquets: [ItemFlower]
    var presents: [ItemFlower]
    var set: [ItemFlower]
    
    
    init(flowers: [ItemFlower], bestsellers: [ItemFlower], bouquets: [ItemFlower], presents: [ItemFlower], set: [ItemFlower]) {
        self.flowers = flowers
        self.bestsellers = bestsellers
        self.bouquets = bouquets
        self.presents = presents
        self.set = set
    }
}

class ItemFlower: Codable {
    var nameFlower: String?
    var description: String?
    var price: Int?
    var urlImage: String?
    
    init(nameFlower: String, description: String, price: Int, urlImage: String) {
        self.nameFlower = nameFlower
        self.description = description
        self.price = price
        self.urlImage = urlImage
    }
}
