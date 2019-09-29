//
//  NetworkServices.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 8/9/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

class NetworkServices {
    
    class func loadJSONData(complition: @escaping(ListFlower?, Error?) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/IVPavel/FlowerShop/d8e44d1bedbe43ede28cd6b363c7d9dd251a07cc/FlowerShop/flower.json") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let decode = try JSONDecoder().decode(ListFlower.self, from: data)
                complition(decode, nil)
            } catch let jsonError {
                complition(nil, jsonError)
            }
        }.resume()
    }
}
