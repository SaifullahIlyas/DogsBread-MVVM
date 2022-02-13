//
//  Api-Extentions.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation

//Change base url to live and live to staging
extension ApiClient {
    static var shared:ApiClient! = ApiClient.init(baseURL: BaseURL.active.rawValue)
    class func clear() {
        shared = nil
        shared = ApiClient.init(baseURL: BaseURL.active.rawValue)
    }
}
