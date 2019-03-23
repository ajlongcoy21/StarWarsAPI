//
//  Endpoint.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

//create a protocol endpoit for the SWAPI

protocol Endpoint
{
    var base: String { get }
    var starWarsAssetSearch: String { get }
    //var queryItems: [URLQueryItem]? { get }
    
}

extension Endpoint
{
    // define url components in the endpoint
    
    var urlComponents: URLComponents
    {

        // add the base url and the url path
        
        var components = URLComponents(string: base)!
        components.path = starWarsAssetSearch
        

        //components.queryItems = queryItems
        
        return components
    }
    
    var request: URLRequest
    {
        // create a url request with the components
        
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
    case searchPlanets(planetNumber: String)
    
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
            case .searchPlanets(planetNumber: let planetNumber):
                return "/api/planets/\(planetNumber)/"
        }
    }
    
}
