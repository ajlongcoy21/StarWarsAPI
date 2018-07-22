//
//  StarWarsAPIError.swift
//  StarWarsAPI
//
//  Created by Alan Longcoy on 7/22/18.
//  Copyright © 2018 Alan Longcoy. All rights reserved.
//

import Foundation

enum StarWarsAPIError: Int, Error
{
    case requestFailed = 1
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case jsonParsingFailure
    
    static var allCases: [String]
    {
        var values: [String] = []
        var index = 1
        while let element = self.init(rawValue: index)
        {
            values.append(element.description)
            index += 1
        }
        return values
    }
}

extension StarWarsAPIError: CustomStringConvertible
{
    var description: String
    {
        switch self
        {
        case .invalidData: return "Invalid data returned by server. Could not be processed/analyzed."
        case .jsonConversionFailure: return "Was not able to convert the JSON data from the server. Please contact the developer to help resolve the issue."
        case .jsonParsingFailure: return "Was not able to parse the JSON data from the server. Please contact the developer to help resolve the issue."
        case .requestFailed: return "Communication request to the server failed. Please make sure that you are connected to the internet and try again."
        case .responseUnsuccessful: return "Server response was unsuccessful. Please try again later."
        }
    }
}
