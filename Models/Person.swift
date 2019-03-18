//
//  Person.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class Person
{
    var name: String
    var born: String
    var planet: String
    var home: String
    var height: String
    var eye_color: String
    var hair_color: String
    
    
    init(name: String, born: String, home: String, height: String, eye_color: String, hair_color: String)
    {
        self.name = name
        self.born = born
        self.home = home
        self.height = height
        self.eye_color = eye_color
        self.hair_color = hair_color
        self.planet = ""
    }
    
    func updatePlanet(name: String)
    {
        self.planet = name
    }
    
    func getHeight() -> Double
    {
        return Double(height) ?? 0.0
    }
}
