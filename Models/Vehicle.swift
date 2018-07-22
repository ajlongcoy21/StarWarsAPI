//
//  Vehicle.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class Vehicle
{
    var name: String
    var make: String
    var cost: String
    var length: String
    var vehicleClass: String
    var crew: String
    
    
    init(name: String, make: String, cost: String, length: String, vehicleClass: String, crew: String)
    {
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
    }
}
