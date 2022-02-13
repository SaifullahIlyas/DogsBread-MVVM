//
//  DogBreadsModel.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation
class ServiceData : Codable {
     let message : [String]?
     let status: String?
}
class BreadsName: ServiceData {
    var breads: [String]? {
       return message
    }
}
class BreadImages : ServiceData {
    var url : [String]? {
        return self.message
    }
}
