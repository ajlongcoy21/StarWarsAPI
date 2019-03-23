//
//  Vehicle.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class Vehicle
{
    var name: String
    var make: String
    var cost: String
    var length: String
    var vehicleClass: String
    var crew: String
    
    
    init(name: String, make: String, cost: String, length: String, vehicleClass: String, crew: String)
    {
        self.name = name
        self.make = make
        self.cost = cost
        self.length = length
        self.vehicleClass = vehicleClass
        self.crew = crew
    }
    
    // return the length of the vehile in metric units as string
    
    func getLengthMetricString() -> String
    {
        return "\(Double(length)!) m"
    }
    
    // return the length of the vehicle in english units as string
    
    func getLengthEnglishString() -> String
    {
        return "\(round(round(Double(length)!/0.0003048)/1000.0)) ft"
    }
    
    // return the cost of the vehicle from the exchange rate entered by the user
    
    func getCostUSDString(exchangeRate: Double) -> String
    {
        if cost != "unknown"
        {
            return "$\(Double(Double(cost)! * exchangeRate).rounded(toPlaces: 2))"
        }
        
        return cost
        
    }
    
    func getCostCreditsString() -> String
    {
        return cost
    }
}

extension Double
{
    /// Rounds the double to decimal places value
    
    func rounded(toPlaces places:Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
