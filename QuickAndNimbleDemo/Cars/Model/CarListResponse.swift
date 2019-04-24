//
//  CarListResponse.swift
//  QuickAndNimbleDemo
//
//  Created by Ashraf on 4/21/19.
//  Copyright © 2019 BS23. All rights reserved.
//

import Foundation
class CarListResponse: Codable {
    let data: [Car]
    
    init() {
        fatalError()
    }
}

class Car :Codable  {
    let manufacturer: String
    let model: String
    let price: Int
    let details: String
    let img: String
    let sold: Bool
    
    enum CodingKeys: String, CodingKey {
        case manufacturer, model, price, details = "wiki", img, sold
    }
    init() {
        fatalError()
    }
}
