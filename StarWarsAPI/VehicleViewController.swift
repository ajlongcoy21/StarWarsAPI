//
//  VehicleViewController.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/27/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import UIKit

class VehicleViewController: UIViewController
{

    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var vehicleClassLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var smallestVehicleLabel: UILabel!
    @IBOutlet weak var largestVehicleLabel: UILabel!
    @IBOutlet weak var vehiclePickerView: UIPickerView!
    
    
    var vehiclePicker: UIPickerView?
    var count: Int = 0
    var smallest: Double = 0.0
    var largest: Double = 0.0
    
    var vehicleSent: Bool = false
    
    var vehicles: Vehicles?
    {
        didSet
        {
            vehicleNameLabel.text = vehicles?.allVehicles[0].name
            makeLabel.text = vehicles?.allVehicles[0].make
            costLabel.text = vehicles?.allVehicles[0].cost
            lengthLabel.text = "\(vehicles?.allVehicles[0].length ?? "0.0")m"
            vehicleClassLabel.text = vehicles?.allVehicles[0].vehicleClass
            crewLabel.text = vehicles?.allVehicles[0].crew
            reloadPickerValues()
            
            for eachVehicle in (vehicles?.allVehicles)!
            {
                if count == 0
                {
                    smallestVehicleLabel.text = eachVehicle.name
                    largestVehicleLabel.text = eachVehicle.name
                    smallest = Double(eachVehicle.length)!
                    largest = Double(eachVehicle.length)!
                    count = 1
                }
                else
                {
                    if Double(eachVehicle.length)! < smallest
                    {
                        smallestVehicleLabel.text = eachVehicle.name
                        smallest = Double(eachVehicle.length)!
                        
                    }
                    else if Double(eachVehicle.length)! > largest
                    {
                        largestVehicleLabel.text = eachVehicle.name
                        largest = Double(eachVehicle.length)!
                    }
                }
            }
            
            count = 0
        }
    }
    
    var starships: Starships?
    {
        
        didSet
        {
            vehicleNameLabel.text = starships?.allStarships[0].name
            makeLabel.text = starships?.allStarships[0].make
            costLabel.text = starships?.allStarships[0].cost
            lengthLabel.text = "\(starships?.allStarships[0].length ?? "0.0")m"
            vehicleClassLabel.text = starships?.allStarships[0].vehicleClass
            crewLabel.text = starships?.allStarships[0].crew
            reloadPickerValues()
            
            for eachStarship in (starships?.allStarships)!
            {
                if count == 0
                {
                    smallestVehicleLabel.text = eachStarship.name
                    largestVehicleLabel.text = eachStarship.name
                    smallest = Double(eachStarship.length)!
                    largest = Double(eachStarship.length)!
                    count = 1
                }
                else
                {
                    if Double(eachStarship.length)! < smallest
                    {
                        smallestVehicleLabel.text = eachStarship.name
                        smallest = Double(eachStarship.length)!
                        
                    }
                    else if Double(eachStarship.length)! > largest
                    {
                        largestVehicleLabel.text = eachStarship.name
                        largest = Double(eachStarship.length)!
                    }
                }
            }
            
            count = 0
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        vehiclePickerView.dataSource = self
        vehiclePickerView.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func reloadPickerValues()
    {
        vehiclePickerView.dataSource = self
        vehiclePickerView.delegate = self
        vehiclePickerView.reloadAllComponents()
        
        
    }
    
}

extension VehicleViewController: UIPickerViewDataSource, UIPickerViewDelegate
{
    
    // Mark - Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if vehicleSent
        {
            if vehicles == nil
            {
                return 0
            }
            else
            {
                return vehicles!.allVehicles.count
            }
        }
        else
        {
            if starships == nil
            {
                return 0
            }
            else
            {
                return starships!.allStarships.count
            }
        }

        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if vehicleSent
        {
            if vehicles == nil
            {
                return ""
            }
            else
            {
                return vehicles!.allVehicles[row].name
            }
        }
        else
        {
            if starships == nil
            {
                return ""
            }
            else
            {
                return starships!.allStarships[row].name
            }
            
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if vehicleSent
        {
            vehicleNameLabel.text = vehicles?.allVehicles[row].name
            makeLabel.text = vehicles?.allVehicles[row].make
            costLabel.text = vehicles?.allVehicles[row].cost
            lengthLabel.text = "\(vehicles?.allVehicles[row].length ?? "0.0")m"
            vehicleClassLabel.text = vehicles?.allVehicles[row].vehicleClass
            crewLabel.text = vehicles?.allVehicles[row].crew
        }
        else
        {
            vehicleNameLabel.text = starships?.allStarships[row].name
            makeLabel.text = starships?.allStarships[row].make
            costLabel.text = starships?.allStarships[row].cost
            lengthLabel.text = "\(starships?.allStarships[row].length ?? "0.0")m"
            vehicleClassLabel.text = starships?.allStarships[row].vehicleClass
            crewLabel.text = starships?.allStarships[row].crew
        }
        
    }
    
    
}
