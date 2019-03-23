//
//  StarWarsAPIClient.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class StarWarsClient
{
    let downloader = JSONDownloader()
    
    /*
     searchForPeople
     
     Inputs: completionHandler
     outputs: none
     
     The objective of this function is to create the endpoint to initate the request for people. We then handle the response
     from the request.
     
     */
    
    func searchForPeople(completion: @escaping (People?, StarWarsAPIError?) -> Void)
    {
        // setup the endpoint for the request
        
        let endpoint = StarWarsAPI.searchPeople
        
        performRequest(with: endpoint)
        {
            results, error in
            
            // check to see if we have valid results, if not throw error
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            // create people from the valid data returned
            
            let people = People(json: results)
            
            completion(people, nil)
            
        }
        
    }
    
    /*
     searchForVehicles
     
     Inputs: completionHandler
     outputs: none
     
     The objective of this function is to create the endpoint to initate the request for vehicles. We then handle the response
     from the request.
     
     */
    
    func searchForVehicles(completion: @escaping (Vehicles?, StarWarsAPIError?) -> Void)
    {
        // setup the endpoint for the request
        
        let endpoint = StarWarsAPI.searchVehicles
        
        performRequest(with: endpoint)
        {
            results, error in
            
            // check to see if we have valid results, if not throw error
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            // create vehicles from the valid data returned
            
            let vehicles = Vehicles(json: results)
            
            completion(vehicles, nil)
            
        }
    }
    
    /*
     searchForStarships
     
     Inputs: completionHandler
     outputs: none
     
     The objective of this function is to create the endpoint to initate the request for starships. We then handle the
     response from the request.
     
     */
    
    func searchForStarships(completion: @escaping (Starships?, StarWarsAPIError?) -> Void)
    {
        // setup the endpoint for the request
        
        let endpoint = StarWarsAPI.searchStarships
        
        performRequest(with: endpoint)
        {
            results, error in
            
            // check to see if we have valid results, if not throw error
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            // create starships from the valid data returned
            
            let starships = Starships(json: results)
            
            completion(starships, nil)
            
        }
    }
    
    /*
     searchForPlanets
     
     Inputs: completionHandler
     outputs: none
     
     The objective of this function is to create the endpoint to initate the request for planets. We then handle the response
     from the request.
     
     */
    
    func searchForPlanets(planetNumber: String, completion: @escaping (Planet?, StarWarsAPIError?) -> Void)
    {
        // setup the endpoint for the request
        
        let endpoint = StarWarsAPI.searchPlanets(planetNumber: planetNumber)
        
        performRequest2(with: endpoint)
        {
            results, error in
            
            // check to see if we have valid results, if not throw error
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            // create planet from the valid data returned
            
            let planet = Planet(json: results)
            
            completion(planet, nil)
            
        }
    }
    
    // define typealias
    
    typealias Results = [[String: Any]]
    typealias Results2 = [String: Any]
    
    /*
     performRequest
     
     Inputs: endpoint, completionHandler
     outputs: none
     
     The objective of this function is to initiate the network task and asynchronously wait for the data to be returned to the
     request. we use resuts as the data structure returned.
     
     */
    
    private func performRequest(with endpoint: Endpoint, completion: @escaping (Results?, StarWarsAPIError?) -> Void)
    {
        // create the network task
        
        let task = downloader.jsonTask(with: endpoint.request)
        {
            json, error in
            
            // initiate the async code to handle the data returned
            
            DispatchQueue.main.async
                {
                    // check to see if we have valid data
                    
                    guard let json = json else
                    {
                        completion(nil, error)
                        return
                    }
                    
                    // check to see if we got expected data returned from request
                    
                    guard let results = json["results"] as? [[String: Any]] else
                    {
                        completion([], .jsonParsingFailure)
                        return
                    }
                    
                    // return results
                    
                    completion(results, nil)
            }
            
        }
        
        task.resume()
        
    }
    
    /*
     performRequest
     
     Inputs: endpoint, completionHandler
     outputs: none
     
     The objective of this function is to initiate the network task and asynchronously wait for the data to be returned to the
     request. We use the results2 as the data structure returned
     
     */
    
    private func performRequest2(with endpoint: Endpoint, completion: @escaping (Results2?, StarWarsAPIError?) -> Void)
    {
        // create network task
        
        let task = downloader.jsonTask(with: endpoint.request)
        {
            json, error in
            
            // initiate the async code to handle the data returned
            
            DispatchQueue.main.async
            {
                    // check to see if valid data was returned
                
                    guard let json = json else
                    {
                        completion(nil, error)
                        return
                    }
                
                    // return results
                
                    completion(json, nil)
            }
            
        }
        
        // resume task
        
        task.resume()
        
    }
}
