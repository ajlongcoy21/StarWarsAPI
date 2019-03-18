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
        
        setupNavBar()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
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

    }
    
    @IBAction func StarshipSearch(_ sender: Any)
    {
        
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
                            
                            peopleViewController.people = people
                            
                        }
                    }
            }
        }
        
        if segue.identifier == "ShowVehicles"
        {
            let vehicleViewController = segue.destination as! VehicleViewController
            let vc = segue.destination as UIViewController
            vc.navigationItem.title = "Vehicles"
            
            
            client.searchForVehicles()
            {
                    vehicles, error in
                    
                    guard let vehicles = vehicles else
                    {
                        return
                    }
                
                    vehicleViewController.vehicleSent = true
                    vehicleViewController.vehicles = vehicles
            
            }
        }
        
        if segue.identifier == "ShowStarships"
        {
            let vehicleViewController = segue.destination as! VehicleViewController
            let vc = segue.destination as UIViewController
            vc.navigationItem.title = "Starships "
            
            
            client.searchForStarships()
                {
                    starships, error in
                    
                    guard let starships = starships else
                    {
                        return
                    }
                    
                    vehicleViewController.vehicleSent = false
                    vehicleViewController.starships = starships
                    
            }
        }
    }
    
    func setupNavBar()
    {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.lightGray]
        self.navigationController!.navigationBar.tintColor = UIColor.lightGray
        self.navigationController!.navigationBar.isTranslucent = false
    }
}

