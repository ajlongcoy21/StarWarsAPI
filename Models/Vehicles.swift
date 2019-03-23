//
//  Vehicles.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class Vehicles
{
    // define variables
    
    var allVehicles: [Vehicle]
    
    // init for the class
    
    init(allVehicles: [Vehicle])
    {
        self.allVehicles = allVehicles
    }
}

extension Vehicles
{
    // convenience init used to create the vehicles class from data returned in the api request
    
    convenience init?(json: [[String: Any]])
    {
        // keys used inthe JSON data
        
        struct Key
        {
            static let name = "name"
            static let make = "model"
            static let cost = "cost_in_credits"
            static let length = "length"
            static let vehicleClass = "vehicle_class"
            static let crew = "crew"
        }
        
        var allVehicles: [Vehicle] = []
        
        // iterate through the vehicles in the JSON data checking to make sure all fields are valid
        
        for eachVehicle in json
        {
            
            guard let name = eachVehicle[Key.name] as? String else
            {
                return nil
            }
            
            guard let make = eachVehicle[Key.make] as? String else
            {
                return nil
            }
            
            guard let cost = eachVehicle[Key.cost] as? String else
            {
                return nil
            }
            
            guard let length = eachVehicle[Key.length] as? String else
            {
                return nil
            }
            
            guard let vehicleClass = eachVehicle[Key.vehicleClass] as? String else
            {
                return nil
            }
            
            guard let crew = eachVehicle[Key.crew] as? String else
            {
                return nil
            }
            
            allVehicles.append(Vehicle(name: name, make: make, cost: cost, length: length, vehicleClass: vehicleClass, crew: crew))
        }
        
        self.init(allVehicles: allVehicles)
    }
}
