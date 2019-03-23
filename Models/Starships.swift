//
//  Starships.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class Starships
{
    // define variables
    
    var allStarships: [Vehicle]
    
    // init for the class
    
    init(allStarships: [Vehicle])
    {
        self.allStarships = allStarships
    }
}

extension Starships
{
    // convenience init used to create the starships class from data returned in the api request
    
    convenience init?(json: [[String: Any]])
    {
        // keys used inthe JSON data
        
        struct Key
        {
            static let name = "name"
            static let make = "model"
            static let cost = "cost_in_credits"
            static let length = "length"
            static let starshipClass = "starship_class"
            static let crew = "crew"
        }
        
        var allStarships: [Vehicle] = []
        
        // iterate through the starships in the JSON data checking to make sure all fields are valid
        
        for eachStarship in json
        {
            
            guard let name = eachStarship[Key.name] as? String else
            {
                return nil
            }
            
            guard let make = eachStarship[Key.make] as? String else
            {
                return nil
            }
            
            guard let cost = eachStarship[Key.cost] as? String else
            {
                return nil
            }
            
            guard let length = eachStarship[Key.length] as? String else
            {
                return nil
            }
            
            guard let starshipClass = eachStarship[Key.starshipClass] as? String else
            {
                return nil
            }
            
            guard let crew = eachStarship[Key.crew] as? String else
            {
                return nil
            }
            
            allStarships.append(Vehicle(name: name, make: make, cost: cost, length: length, vehicleClass: starshipClass, crew: crew))
        }
        
        self.init(allStarships: allStarships)
    }
}
