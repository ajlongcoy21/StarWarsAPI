//
//  People.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class People
{
    // define variables
    
    var allPeople: [Person]
    var allPeopleNames: [String] = []
    
    // init for the class
    
    init(allPeople: [Person])
    {
        self.allPeople = allPeople

        for eachPerson in allPeople
        {
            allPeopleNames.append(eachPerson.name)
            //print(eachPerson.name)
            //print(eachPerson.height)
        }
    }
}

extension People
{
    // convenience init used to create the people class from data returned in the api request
    
    convenience init?(json: [[String: Any]])
    {
        // keys used inthe JSON data
        
        struct Key
        {
            static let name = "name"
            static let born = "birth_year"
            static let home = "homeworld"
            static let height = "height"
            static let eye_color = "eye_color"
            static let hair_color = "hair_color"
        }
        
        var allPeople: [Person] = []
        
        // iterate through the people in the JSON data checking to make sure all fields are valid
        
        for eachPerson in json
        {
            
            guard let name = eachPerson[Key.name] as? String else
            {
                return nil
            }
            
            guard let born = eachPerson[Key.born] as? String else
            {
                return nil
            }
            
            guard let home = eachPerson[Key.home] as? String else
            {
                return nil
            }
            
            guard let height = eachPerson[Key.height] as? String else
            {
                return nil
            }

            guard let eye_color = eachPerson[Key.eye_color] as? String else
            {
                return nil
            }
            
            guard let hair_color = eachPerson[Key.hair_color] as? String else
            {
                return nil
            }
            
            allPeople.append(Person(name: name, born: born, home: home, height: height, eye_color: eye_color, hair_color: hair_color))
        }
        
        self.init(allPeople: allPeople)
    }
}
