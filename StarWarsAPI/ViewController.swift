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
    //define variables
    @IBOutlet weak var navigationBar: UINavigationItem!
    let client = StarWarsClient() // create api client

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
    
    /*
     prepare
     
     Inputs: UIStoryboardSegue and sender as Any
     outputs: none
     
     The objective of this function is to prepare the segue for transition to the next appropriate screen based on the button
     clicked by the user.
     
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = ""
        
        // People button clicked
        
        if segue.identifier == "ShowPeople"
        {
            // setup view controller to pass information once the api request is returned
            let peopleViewController = segue.destination as! PeopleViewController
            let vc = segue.destination as UIViewController
            vc.navigationItem.title = "Characters"
            
            // perform the api request for the people data
            
            client.searchForPeople()
            {
                    people, error in
                
                    // check if data is valid
                
                    guard let people = people else
                    {
                        // error display code - if there is an issue, display error and go back to previous view
                        
                        switch error!
                        {
                        case StarWarsAPIError.invalidData:
                            self.showError(errorTitle: "Invalid Data", errorDescription: StarWarsAPIError.invalidData.description)
                        case StarWarsAPIError.jsonConversionFailure:
                            self.showError(errorTitle: "Unable to read data", errorDescription: StarWarsAPIError.jsonConversionFailure.description)
                        case StarWarsAPIError.jsonParsingFailure:
                            self.showError(errorTitle: "Unable to read data", errorDescription: StarWarsAPIError.jsonParsingFailure.description)
                        case StarWarsAPIError.requestFailed:
                            self.showError(errorTitle: "Request Failed", errorDescription: StarWarsAPIError.requestFailed.description)
                        case StarWarsAPIError.responseUnsuccessful:
                            self.showError(errorTitle: "Response Unsuccessful", errorDescription: StarWarsAPIError.responseUnsuccessful.description)
                        }
                        
                        self.navigationController?.popViewController(animated: true)
                        return
                    }
                
                    // if the data is valid, interate through all people to obtain their home planet information
                
                    for eachPerson in people.allPeople
                    {
                        let fullPlanetURL : String = eachPerson.home
                        let fullPlanetURLArr : [String] = fullPlanetURL.components(separatedBy: "/")
                        
                        // perform api request for the planet information
                        
                        self.client.searchForPlanets(planetNumber: fullPlanetURLArr[5])
                        {
                            planet, error in
                            
                            // check if planet data is valid
                            
                            guard let planet = planet else
                            {
                                return
                            }
                            
                            // if data is valid, add information to the person
                            
                            eachPerson.updatePlanet(name: planet.name)
                            
                            // pass updated info to the new view controller
                            
                            peopleViewController.people = people
                            
                        }
                    }
            }
        }
        
        // vehicle button clicked
        
        if segue.identifier == "ShowVehicles"
        {
            // setup view controller to pass information once the api request is returned
            
            let vehicleViewController = segue.destination as! VehicleViewController
            let vc = segue.destination as UIViewController
            vc.navigationItem.title = "Vehicles"
            
            // perform the api request for the vehicles data
            
            client.searchForVehicles()
            {
                    vehicles, error in
                
                    //check if vehicle data is valid
                
                    guard let vehicles = vehicles else
                    {
                        // error display code - if there is an issue, display error and go back to previous view
                        
                        switch error!
                        {
                        case StarWarsAPIError.invalidData:
                            self.showError(errorTitle: "Invalid Data", errorDescription: StarWarsAPIError.invalidData.description)
                        case StarWarsAPIError.jsonConversionFailure:
                            self.showError(errorTitle: "Unable to read data", errorDescription: StarWarsAPIError.jsonConversionFailure.description)
                        case StarWarsAPIError.jsonParsingFailure:
                            self.showError(errorTitle: "Unable to read data", errorDescription: StarWarsAPIError.jsonParsingFailure.description)
                        case StarWarsAPIError.requestFailed:
                            self.showError(errorTitle: "Request Failed", errorDescription: StarWarsAPIError.requestFailed.description)
                        case StarWarsAPIError.responseUnsuccessful:
                            self.showError(errorTitle: "Response Unsuccessful", errorDescription: StarWarsAPIError.responseUnsuccessful.description)
                        }
                        
                        self.navigationController?.popViewController(animated: true)
                        return
                    }
                
                    // pass updated data to new view controller
                
                    vehicleViewController.vehicleSent = true
                    vehicleViewController.vehicles = vehicles
            
            }
        }
        
        // starship button clicked
        
        if segue.identifier == "ShowStarships"
        {
            // setup view controller to pass information once the api request is returned
            
            let vehicleViewController = segue.destination as! VehicleViewController
            let vc = segue.destination as UIViewController
            vc.navigationItem.title = "Starships "
            
            // perform the api request for the vehicles data
            
            client.searchForStarships()
                {
                    starships, error in
                    
                    // check to see if starship data if valid
                    
                    guard let starships = starships else
                    {
                        // error display code - if there is an issue, display error and go back to previous view
                        
                        switch error!
                        {
                        case StarWarsAPIError.invalidData:
                            self.showError(errorTitle: "Invalid Data", errorDescription: StarWarsAPIError.invalidData.description)
                        case StarWarsAPIError.jsonConversionFailure:
                            self.showError(errorTitle: "Unable to read data", errorDescription: StarWarsAPIError.jsonConversionFailure.description)
                        case StarWarsAPIError.jsonParsingFailure:
                            self.showError(errorTitle: "Unable to read data", errorDescription: StarWarsAPIError.jsonParsingFailure.description)
                        case StarWarsAPIError.requestFailed:
                            self.showError(errorTitle: "Request Failed", errorDescription: StarWarsAPIError.requestFailed.description)
                        case StarWarsAPIError.responseUnsuccessful:
                            self.showError(errorTitle: "Response Unsuccessful", errorDescription: StarWarsAPIError.responseUnsuccessful.description)
                        }
                        
                        
                        return
                    }
                    
                    // pass updated data to new view controller
                    
                    vehicleViewController.vehicleSent = false
                    vehicleViewController.starships = starships
                    
            }
        }
    }
    
    /*
    setupNavBar
    
    Inputs: none
    outputs: none
    
    The objective of this function is to configure the navbar to match the mockups
    
    */
    
    func setupNavBar()
    {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.lightGray]
        self.navigationController!.navigationBar.tintColor = UIColor.lightGray
        self.navigationController!.navigationBar.isTranslucent = false
    }
    
    func showError(errorTitle: String, errorDescription: String)
    {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: errorTitle, message: errorDescription, preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "OK", style: .default)
        { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
}

