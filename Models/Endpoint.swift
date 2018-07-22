//
//  Endpoint.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

protocol Endpoint
{
    var base: String { get }
    var starWarsAssetSearch: String { get }
    //var queryItems: [URLQueryItem]? { get }
    
}

extension Endpoint
{
    var urlComponents: URLComponents
    {

        var components = URLComponents(string: base)!
        components.path = starWarsAssetSearch
        

        //components.queryItems = queryItems
        
        return components
    }
    
    var request: URLRequest
    {
        let url = urlComponents.url!
        let urlRequest =  URLRequest(url: url)
        
        return urlRequest
    }
}

enum StarWarsAPI
{
    case searchPeople
    case searchVehicles
    case searchStarships
    
}

extension StarWarsAPI: Endpoint
{
    
    //Star Wars API Base URL for all requests
    
    var base: String
    {
        return "https://swapi.co"
    }
    
    
    
    var starWarsAssetSearch: String
    {
        switch self
        {
            case .searchPeople:
                return "/api/people/"
            case .searchVehicles:
                return "/api/vehicles/"
            case .searchStarships:
                return "/api/starships/"
        }
    }
    
}
