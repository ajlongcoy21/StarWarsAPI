//
//  Planet.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/24/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class Planet
{
    var name: String
    
    
    init(name: String)
    {
        self.name = name
    }
}

extension Planet
{
    convenience init?(json: [String: Any])
    {
        struct Key
        {
            static let name = "name"
        }
        

        
        guard let name = json[Key.name] as? String else
        {
            return nil
        }
        
        self.init(name: name)
    }
}
