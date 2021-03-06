//
//  PeopleViewController.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/24/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController
{
    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var bornDateLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var starWarsPeoplePicker: UIPickerView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    
    
    var peoplePicker: UIPickerView?
    var count: Int = 0
    var smallest: Int = 0
    var largest: Int = 0
    
    var units: Int = 1
    
    var people: People?
    {
        didSet
        {
            personNameLabel.text = people?.allPeople[0].name
            bornDateLabel.text = people?.allPeople[0].born
            homeLabel.text = people?.allPeople[0].planet
            heightLabel.text = people?.allPeople[0].getHeightMetricString()
            eyeColorLabel.text = people?.allPeople[0].eye_color
            hairColorLabel.text = people?.allPeople[0].hair_color
            reloadPickerValues()
            
            for eachPerson in (people?.allPeople)!
            {
                if count == 0
                {
                    smallestLabel.text = eachPerson.name
                    largestLabel.text = eachPerson.name
                    smallest = Int(eachPerson.height)!
                    largest = Int(eachPerson.height)!
                    count = 1
                }
                else
                {
                    if Int(eachPerson.height)! < smallest
                    {
                        smallestLabel.text = eachPerson.name
                        smallest = Int(eachPerson.height)!

                    }
                    else if Int(eachPerson.height)! > largest
                    {
                        largestLabel.text = eachPerson.name
                        largest = Int(eachPerson.height)!
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
        
        starWarsPeoplePicker.dataSource = self
        starWarsPeoplePicker.delegate = self
        
        englishButton.tag = 0
        metricButton.tag = 1
        
        metricButton.setTitleColor(UIColor.white, for: .normal)
        englishButton.setTitleColor(UIColor.gray, for: .normal)
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
        starWarsPeoplePicker.dataSource = self
        starWarsPeoplePicker.delegate = self
        starWarsPeoplePicker.reloadAllComponents()
    }
    
    @IBAction func unitSelection(_ sender: UIButton)
    {
        if sender.tag == 0
        {
            units = 0
            metricButton.setTitleColor(UIColor.gray, for: .normal)
            englishButton.setTitleColor(UIColor.white, for: .normal)
            
            heightLabel.text = people?.allPeople[(starWarsPeoplePicker?.selectedRow(inComponent: 0))!].getHeightEnglishString()
        }
        else
        {
            units = 1
            englishButton.setTitleColor(UIColor.gray, for: .normal)
            metricButton.setTitleColor(UIColor.white, for: .normal)
            
            heightLabel.text = people?.allPeople[(starWarsPeoplePicker?.selectedRow(inComponent: 0))!].getHeightMetricString()
        }
        
        
    }
    
    
}

extension PeopleViewController: UIPickerViewDataSource, UIPickerViewDelegate
{
    
    // Mark - Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if people == nil
        {
            return 0
        }
        else
        {
            return people!.allPeopleNames.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if people == nil
        {
            return ""
        }
        else
        {
            return people!.allPeopleNames[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        personNameLabel.text = people?.allPeople[row].name
        bornDateLabel.text = people?.allPeople[row].born
        homeLabel.text = people?.allPeople[row].planet
        
        if units == 0
        {
            heightLabel.text = people?.allPeople[row].getHeightEnglishString()
        }
        else
        {
            heightLabel.text = people?.allPeople[row].getHeightMetricString()
        }
        
        eyeColorLabel.text = people?.allPeople[row].eye_color
        hairColorLabel.text = people?.allPeople[row].hair_color
    }
    
    
    
    
}
