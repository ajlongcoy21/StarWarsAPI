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
    var allPeople: [Person]
    
    
    init(allPeople: [Person])
    {
        self.allPeople = allPeople
    }
}

extension People
{
    convenience init?(json: [[String: Any]])
    {
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
