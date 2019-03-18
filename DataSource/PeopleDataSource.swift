//
//  PeopleDataSource.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/25/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation
import UIKit


class PeopleDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate
{
    private var starWarsPeople: [String]
    var selectedRow: Int = 0
    
    init(starWarsPeople: [String])
    {
        self.starWarsPeople = starWarsPeople
        super.init()
    }
    
    // Mark - Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return starWarsPeople.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return starWarsPeople[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedRow = row
    }
    
    
    
}
