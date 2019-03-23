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
    // Person variables
    
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
    
    // add the planet to the person
    
    func updatePlanet(name: String)
    {
        self.planet = name
    }
    
    // return height in the double format for the person
    
    func getHeight() -> Double
    {
        return Double(height) ?? 0.0
    }
    
    // return height in metric format as string
    
    func getHeightMetricString() -> String
    {
        return "\(Double(height)!/100.0) m"
    }
    
    // return height in english format as string
    
    func getHeightEnglishString() -> String
    {
        return "\(round(Double(height)!/0.3048)/100.0) ft"
    }
}
