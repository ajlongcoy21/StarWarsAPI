//
//  JSONDownloader.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

class JSONDownloader
{
    // Definition of variables
    
    let session: URLSession
    var valuesOK = true
    
    //Initialization Function
    
    init(configuration: URLSessionConfiguration)
    {
        // Create a URL Session with the URL Session Configuration
        
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init()
    {
        self.init(configuration: .default)
    }
    
    // type alias definitions
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, StarWarsAPIError?) -> Void
    
    /*
    jsonTask
 
    Inputs: URLRequest and completionHandler
    outputs: URLSessionDataTask
 
    The objective of this function is to receive a URLRequest a initiate the network requests to the api server. Once the
    network is initiated, we check to make sure there are no issues with receiving the data or the network request itself.
     
    */
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask
    {
        // initiate network request
        
        let task = session.dataTask(with: request)
        {
            data, response, error in
            
            // Check the response of the server, if the response is invalid throw error
            
            guard let httpResponse = response as? HTTPURLResponse else
            {
                completion(nil, .requestFailed)
                return
            }
            
            if (httpResponse.statusCode == 200)
            {
                // check data returned
                
                if let data = data
                {
                    // check to see if we can read the JSON data
                    
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    }
                    catch
                    {
                        completion(nil, .jsonConversionFailure)
                    }
                }
                    
                // if data is invalid throw error
                    
                else
                {
                    completion(nil, .invalidData)
                }
            }
              
            // if response is a different code than 200, throw error
                
            else
            {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
        
    }
}
