//
//  Enum+Constants.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation

enum BaseURL: String {
   case active = "https://dog.ceo/api/"
    case live = "nmdndmnd"
}

//MARK: Handle Errors
public enum NetworkError: Error {
    case invalidURL
    case invalidParameters
    case noResponse
    case notSupported
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidParameters:
            return "Invalid Parameters"
        case .noResponse:
            return "No Response"
            case .notSupported:
            return "Not Supported"
        }
    }
}

//MARK: Api Call
public enum Endpoints: String {
    case breadlist = "breeds/list"
    case breadImages = "breed/%@/images"
    
    
}


