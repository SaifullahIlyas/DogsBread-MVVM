//
//  PreviewVM.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 13/02/2022.
//

import Foundation
import Combine
class PreviewVM : NSObject {
     var imageURL : String = ""
    @Published private(set) var imageData  : Data =  Data()
    override init() {
        
    }
    init(url : String) {
        self.imageURL = url
    }
    
     func loadImage() {
        ImageDownLoader.image(fromURL: self.imageURL) { _, data in
            guard let data = data else {return}
            self.update(imageData: data)
        }
    }
}
//MARK:- Mutabiltyy
private extension PreviewVM {
   func update(imageData data : Data) {
    self.imageData = data
    }
}
