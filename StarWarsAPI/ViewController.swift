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
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    let client = StarWarsClient()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func CharacterSearch(_ sender: Any)
    {
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = ""
        
        if segue.identifier == "ShowPeople"
        {
            let peopleViewController = segue.destination as! PeopleViewController
            let vc = segue.destination as UIViewController
            vc.navigationItem.title = "Characters"
            
            client.searchForPeople()
            {
                    people, error in
                    
                    guard let people = people else
                    {
                        return
                    }
                    
                    for eachPerson in people.allPeople
                    {
                        let fullPlanetURL : String = eachPerson.home
                        let fullPlanetURLArr : [String] = fullPlanetURL.components(separatedBy: "/")
                        
                        
                        self.client.searchForPlanets(planetNumber: fullPlanetURLArr[5])
                        {
                            planet, error in
                            
                            guard let planet = planet else
                            {
                                return
                            }
                            
                            eachPerson.updatePlanet(name: planet.name)
                            print(eachPerson.planet)
                            
                            peopleViewController.people = people.allPeople
                        }
                    }
            }
        }
        
    }
}

