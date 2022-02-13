//
//  CellsVM.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 13/02/2022.
//

import Foundation

class DogBreadNameVM : NSObject {
    let title : String
    required  init(title : String) {
        self.title = title
    }
  
    
}
class DogBreadImageVM {
    let url : String
    required init(url :String){
        self.url = url
    }
}
