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
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    
    
    var vehiclePicker: UIPickerView?
    var count: Int = 0
    var smallest: Double = 0.0
    var largest: Double = 0.0
    var exchangeValue: Double = -1.0
    
    var vehicleSent: Bool = false
    
    var units: Int = 1
    var money: Int = 1
    
    var vehicles: Vehicles?
    {
        didSet
        {
            vehicleNameLabel.text = vehicles?.allVehicles[0].name
            makeLabel.text = vehicles?.allVehicles[0].make
            costLabel.text = vehicles?.allVehicles[0].getCostCreditsString()
            lengthLabel.text = vehicles?.allVehicles[0].getLengthMetricString()
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
            costLabel.text = starships?.allStarships[0].getCostCreditsString()
            lengthLabel.text = starships?.allStarships[0].getLengthEnglishString()
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
        
        englishButton.tag = 0
        metricButton.tag = 1
        
        usdButton.tag = 0
        creditsButton.tag = 1
        
        metricButton.setTitleColor(UIColor.white, for: .normal)
        englishButton.setTitleColor(UIColor.gray, for: .normal)
        
        creditsButton.setTitleColor(UIColor.white, for: .normal)
        usdButton.setTitleColor(UIColor.gray, for: .normal)
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
    
    @IBAction func unitSelection(_ sender: UIButton)
    {
        if sender.tag == 0 && vehicleSent
        {
            units = 0
            metricButton.setTitleColor(UIColor.gray, for: .normal)
            englishButton.setTitleColor(UIColor.white, for: .normal)
            
            lengthLabel.text = vehicles?.allVehicles[vehiclePickerView.selectedRow(inComponent: 0)].getLengthEnglishString()
        }
        else if sender.tag == 0 && !vehicleSent
        {
            units = 0
            metricButton.setTitleColor(UIColor.gray, for: .normal)
            englishButton.setTitleColor(UIColor.white, for: .normal)
            
            lengthLabel.text = starships?.allStarships[vehiclePickerView.selectedRow(inComponent: 0)].getLengthEnglishString()
        }
        else if sender.tag == 1 && vehicleSent
        {
            units = 1
            metricButton.setTitleColor(UIColor.white, for: .normal)
            englishButton.setTitleColor(UIColor.gray, for: .normal)
            
            lengthLabel.text = vehicles?.allVehicles[vehiclePickerView.selectedRow(inComponent: 0)].getLengthMetricString()
        }
        
        else
        {
            units = 1
            metricButton.setTitleColor(UIColor.white, for: .normal)
            englishButton.setTitleColor(UIColor.gray, for: .normal)
            
            lengthLabel.text = starships?.allStarships[vehiclePickerView.selectedRow(inComponent: 0)].getLengthMetricString()
        }
    }
    
    
    @IBAction func currencySelection(_ sender: UIButton)
    {
        if sender.tag == 1 && self.vehicleSent && self.exchangeValue > 0
        {
            self.money = 1
            self.creditsButton.setTitleColor(UIColor.white, for: .normal)
            self.usdButton.setTitleColor(UIColor.gray, for: .normal)
            
            self.costLabel.text = self.vehicles?.allVehicles[self.vehiclePickerView.selectedRow(inComponent: 0)].getCostCreditsString()
        }
            
        else  if sender.tag == 1 && !self.vehicleSent && self.exchangeValue > 0
        {
            self.money = 1
            self.creditsButton.setTitleColor(UIColor.white, for: .normal)
            self.usdButton.setTitleColor(UIColor.gray, for: .normal)
            
            self.costLabel.text = self.starships?.allStarships[self.vehiclePickerView.selectedRow(inComponent: 0)].getCostCreditsString()
        }
        
        else
        {
            //Creating UIAlertController and
            //Setting title and message for the alert dialog
            let alertController = UIAlertController(title: "Enter Exchange Rate", message: "Enter USD per Credit", preferredStyle: .alert)
            
            //the confirm action taking the inputs
            let confirmAction = UIAlertAction(title: "Enter", style: .default)
            { (_) in

                //getting the input values from user
                var userInput = ""
                userInput = alertController.textFields![0].text!
                
                if let exchangeRateInput = Double(userInput)
                {
                    self.exchangeValue = exchangeRateInput
                }
                else
                {
                    self.showExchangeRateError()
                }
                
                if self.exchangeValue == 0
                {
                    self.showExchangeRateError()
                }
                
                if sender.tag == 0 && self.vehicleSent && self.exchangeValue > 0
                {
                    self.money = 0
                    self.creditsButton.setTitleColor(UIColor.gray, for: .normal)
                    self.usdButton.setTitleColor(UIColor.white, for: .normal)
                    
                    self.costLabel.text = self.vehicles?.allVehicles[self.vehiclePickerView.selectedRow(inComponent: 0)].getCostUSDString(exchangeRate: self.exchangeValue)
                }
                else if sender.tag == 0 && !self.vehicleSent && self.exchangeValue > 0
                {
                    self.money = 0
                    self.creditsButton.setTitleColor(UIColor.gray, for: .normal)
                    self.usdButton.setTitleColor(UIColor.white, for: .normal)
                    
                    self.costLabel.text = self.starships?.allStarships[self.vehiclePickerView.selectedRow(inComponent: 0)].getCostUSDString(exchangeRate: self.exchangeValue)
                }
            }
            
            //the cancel action doing nothing
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            { (_) in }
            
            //adding textfields to our dialog box
            alertController.addTextField
                { (textField) in
                    textField.placeholder = "Enter Exchange Rate"
                    textField.keyboardType = UIKeyboardType.decimalPad
            }
            
            //adding the action to dialogbox
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            //finally presenting the dialog box
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func showExchangeRateError()
    {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Exchange Rate", message: "The exchange rate must be a valid number and greater than 0.", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "OK", style: .default)
        { (_) in }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
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
            
            if money == 0
            {
                costLabel.text = vehicles?.allVehicles[row].getCostUSDString(exchangeRate: self.exchangeValue)
            }
            else
            {
                costLabel.text = vehicles?.allVehicles[row].getCostCreditsString()
            }
            
            
            if units == 0
            {
                lengthLabel.text = vehicles?.allVehicles[row].getLengthEnglishString()
            }
            else
            {
                lengthLabel.text = vehicles?.allVehicles[row].getLengthMetricString()
            }
            
            vehicleClassLabel.text = vehicles?.allVehicles[row].vehicleClass
            crewLabel.text = vehicles?.allVehicles[row].crew
        }
        else
        {
            vehicleNameLabel.text = starships?.allStarships[row].name
            makeLabel.text = starships?.allStarships[row].make
            
            if money == 0
            {
                costLabel.text = starships?.allStarships[row].getCostUSDString(exchangeRate: self.exchangeValue)
            }
            else
            {
                costLabel.text = starships?.allStarships[row].getCostCreditsString()
            }
            
            if units == 0
            {
                lengthLabel.text = starships?.allStarships[row].getLengthEnglishString()
            }
            else
            {
                lengthLabel.text = starships?.allStarships[row].getLengthMetricString()
            }
            
            vehicleClassLabel.text = starships?.allStarships[row].vehicleClass
            crewLabel.text = starships?.allStarships[row].crew
        }
        
    }
    
    
}
