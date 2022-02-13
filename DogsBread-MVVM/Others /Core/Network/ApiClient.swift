//
//  ApiClient.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation
public class ApiClient {
    //MARK: iVars
    private let baseURL: String
    
    var headers : HTTPHeaders {
        [:]
    }
    
    //MARK: initializers
    public required init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    
    public func execute<Resp>(with endpoint : String,forRequestMethod method : HTTPMethod,withResponse response : Resp.Type) throws -> Resp where Resp : Decodable{
        return try  ApiRequest(baseURL: self.baseURL, endPoint: endpoint, headers: headers, method: method).execute(result: Resp.self)
    }
    
    
}

//MARK: Private
extension ApiClient {}

