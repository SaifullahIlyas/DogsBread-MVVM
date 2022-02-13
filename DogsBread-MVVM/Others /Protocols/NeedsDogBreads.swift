//
//  NeedsDogBreads.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation

protocol  NeedsDogsBread  : MappableToVM   {
    
}
extension NeedsDogsBread  {
    func fetchDogsBreads()->[DogBreadNameVM] {
        let group = DispatchGroup()
        group.enter()
        var vmBreadsName  : [DogBreadNameVM]! = []
        let result =  try? ApiClient.shared.execute(with: Endpoints.breadlist.rawValue, forRequestMethod: .GET, withResponse: BreadsName.self)
             vmBreadsName =  self.mapableToVMType(type: result?.breads) ?? []
            group.leave()
                   
        group.wait()
          
        return vmBreadsName
    
    }
    func mapableToVMType(type: [String]?) -> [DogBreadNameVM]? {
        type?.compactMap{DogBreadNameVM(title: $0 )}
    }
}
