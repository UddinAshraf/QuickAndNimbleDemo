//
//  CarViewModel.swift
//  QuickAndNimbleDemo
//
//  Created by Ashraf on 4/21/19.
//  Copyright © 2019 BS23. All rights reserved.
//

import Foundation

class CarViewModel {
    private var car: Car
    
    public init(car : Car) {
        self.car = car
    }
    
    public var title: String{
        return car.manufacturer
    }
    
    public var model: String {
        return car.model
    }
    
    public var price: String {
        return String(Int(car.price)) + " $"
    }
    
    public var imgString: String{
        return car.img
    }
    
    public var isSold: Bool {
        return car.sold
    }
}
