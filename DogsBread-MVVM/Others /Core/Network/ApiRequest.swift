//
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//
//

import Foundation
public typealias HTTPHeaders = [String:String]
public enum HTTPMethod :String {
    case GET
    
}
public class ApiRequest {
    
    //MARK: iVars
   // private let request: Data
    private var actualRequest: URLRequest?
    private let baseURL: String
    private let endPoint: String
    private let headers: HTTPHeaders
    private let method: HTTPMethod
    
    private lazy var group: DispatchGroup = {
        return DispatchGroup.init()
    }()
    private lazy var session: URLSession = URLSession.shared
            public required init( baseURL: String, endPoint: String, headers: HTTPHeaders, method: HTTPMethod) throws {
                self.baseURL = baseURL
                self.endPoint = endPoint
                self.headers = headers
                self.method = method
                
            }
        
    
    public func execute<Resp>(result: Resp.Type) throws -> Resp where Resp : Decodable {
        assert(Thread.current != Thread.main, "Should not be called from main threa")
        let urlString = self.baseURL + self.endPoint
        guard let url = URL.init(string: urlString) else {
            throw NetworkError.invalidURL
        }
        var result: Result<Resp,Error>!
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = headers
        group.enter()
        let task =  session.dataTask(with: request) { data, response, error in
            
            guard error == nil ,let data = data else {
                result = Result.failure(NetworkError.noResponse)
                self.group.leave()
                return
                
            } //todo error error
            if let decoded  = try?   JSONDecoder().decode(Resp.self, from: data) {
                result = Result.success(decoded)
            }
            else {
                result = Result.failure(NetworkError.noResponse)
            }
        
            
            
            self.group.leave()
        }
        
        task.resume()
        group.wait()
       
        
        switch result! {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}

