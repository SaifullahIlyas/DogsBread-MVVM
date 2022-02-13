//
//  MappableToVM.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation

protocol MappableToVM : AnyObject {
    associatedtype MapableType = Any
    associatedtype InputType = Any
    func mapableToVMType( type : InputType?)->MapableType?
}
