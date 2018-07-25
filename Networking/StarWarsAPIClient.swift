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
    
    func searchForPeople(completion: @escaping (People?, StarWarsAPIError?) -> Void)
    {
        let endpoint = StarWarsAPI.searchPeople
        
        performRequest(with: endpoint)
        {
            results, error in
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            let people = People(json: results)
            
            completion(people, nil)
            
        }
        
    }
    
    func searchForVehicles(completion: @escaping (Vehicles?, StarWarsAPIError?) -> Void)
    {
        let endpoint = StarWarsAPI.searchVehicles
        
        performRequest(with: endpoint)
        {
            results, error in
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            let vehicles = Vehicles(json: results)
            
            completion(vehicles, nil)
            
        }
    }
    
    func searchForStarships(completion: @escaping (Starships?, StarWarsAPIError?) -> Void)
    {
        let endpoint = StarWarsAPI.searchStarships
        
        performRequest(with: endpoint)
        {
            results, error in
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            let starships = Starships(json: results)
            
            completion(starships, nil)
            
        }
    }
    
    func searchForPlanets(planetNumber: String, completion: @escaping (Planet?, StarWarsAPIError?) -> Void)
    {
        let endpoint = StarWarsAPI.searchPlanets(planetNumber: planetNumber)
        
        performRequest2(with: endpoint)
        {
            results, error in
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            let planet = Planet(json: results)
            
            completion(planet, nil)
            
        }
    }
    
    typealias Results = [[String: Any]]
    typealias Results2 = [String: Any]
    
    private func performRequest(with endpoint: Endpoint, completion: @escaping (Results?, StarWarsAPIError?) -> Void)
    {
        
        let task = downloader.jsonTask(with: endpoint.request)
        {
            json, error in
            
            DispatchQueue.main.async
                {
                    guard let json = json else
                    {
                        completion(nil, error)
                        return
                    }
                    
                    guard let results = json["results"] as? [[String: Any]] else
                    {
                        completion([], .jsonParsingFailure)
                        return
                    }
                    
                    completion(results, nil)
            }
            
        }
        
        task.resume()
        
    }
    
    private func performRequest2(with endpoint: Endpoint, completion: @escaping (Results2?, StarWarsAPIError?) -> Void)
    {
        
        let task = downloader.jsonTask(with: endpoint.request)
        {
            json, error in
            
            DispatchQueue.main.async
            {
                    guard let json = json else
                    {
                        completion(nil, error)
                        return
                    }
                    
                    completion(json, nil)
            }
            
        }
        
        task.resume()
        
    }
    
    //below code pending review
    
    /*
    typealias Results2 = [String: Any]
    
    private func performRequest2(with endpoint: Endpoint, completion: @escaping (Results2?, PUBGError?) -> Void)
    {
        
        var task = downloader.jsonTask(with: endpoint.request)
        {
            json, error in
            
            DispatchQueue.main.async
                {
                    guard let json = json else
                    {
                        completion(nil, error)
                        return
                    }
                    
                    guard let results = json["data"] as? [String: Any] else
                    {
                        completion([:], .jsonParsingFailure)
                        return
                    }
                    
                    completion(results, nil)
            }
            
        }
        
        if downloader.requestRemaining! == 0
        {
            let timeToWait = Int(downloader.requestTimeReset!) - Int(NSDate().timeIntervalSince1970) + 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() +  .seconds(timeToWait))
            {
                task = self.downloader.jsonTask(with: endpoint.request)
                {
                    json, error in
                    
                    DispatchQueue.main.async
                        {
                            guard let json = json else
                            {
                                completion(nil, error)
                                return
                            }
                            
                            guard let results = json["data"] as? [String: Any] else
                            {
                                completion([:], .jsonParsingFailure)
                                return
                            }
                            
                            completion(results, nil)
                    }
                    
                }
                task.resume()
            }
        }
        
        task.resume()
        
    }
    
    private func performRequest3(with endpoint: Endpoint, completion: @escaping (Results2?, PUBGError?) -> Void)
    {
        
        let task = downloader.jsonTask(with: endpoint.request)
        {
            json, error in
            
            DispatchQueue.main.async
                {
                    guard let result = json else
                    {
                        completion(nil, error)
                        return
                    }
                    
                    completion(result, nil)
            }
            
        }
        
        task.resume()
        
    }
 */
    
}
