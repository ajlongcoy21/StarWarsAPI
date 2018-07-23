//
//  ViewController.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    let client = StarWarsClient()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        

        

        

        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func CharacterSearch(_ sender: Any)
    {
        client.searchForPeople()
            {
                people, error in
                
                guard let people = people else
                {
                    return
                }
                
                for eachPerson in people.allPeople
                 {
                 print(eachPerson.name)
                 }
                
        }
    }
    
    @IBAction func VehicleSearch(_ sender: Any)
    {
        client.searchForVehicles()
            {
                vehicles, error in
                
                guard let vehicles = vehicles else
                {
                    return
                }
                
                for eachVehicle in vehicles.allVehicles
                 {
                 print(eachVehicle.name)
                 }
                
        }
    }
    
    @IBAction func StarshipSearch(_ sender: Any)
    {
        client.searchForStarships()
            {
                starships, error in
                
                guard let starships = starships else
                {
                    return
                }
                
                for eachStarship in starships.allStarships
                {
                    print(eachStarship.name)
                }
                
        }
    }
}

