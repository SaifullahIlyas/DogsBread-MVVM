//
//  NeedsDogBreadImages.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation

protocol NeedsDogBreadImages : MappableToVM {
    
}
extension NeedsDogBreadImages {
    
    func fetchImages(forBread name : String)->[DogBreadImageVM]{
        let group = DispatchGroup()
        group.enter()
        var dogBreadImagesVMS : [DogBreadImageVM]? = []
        let endPoint =  String(format: Endpoints.breadImages.rawValue, name)
        let result   =  try? ApiClient.shared.execute(with: endPoint , forRequestMethod: .GET, withResponse: BreadImages.self)
        dogBreadImagesVMS =  self.mapableToVMType(type: result?.url)
            group.leave()
                   
        group.wait()
          
        return dogBreadImagesVMS ?? []
    }
    func mapableToVMType(type: [String]?) -> [DogBreadImageVM]? {
        type?.compactMap{DogBreadImageVM(url: $0 )}
    }
}
