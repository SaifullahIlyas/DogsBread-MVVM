//
//  InstantiateFromStoryBoard.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit

protocol InstantiateFromStoryBoard {
    
}
extension InstantiateFromStoryBoard where Self : UIViewController {
    func  instance(usingStoryboard name : Storyboards, andIdentifier idf : ViewControllerIdentifier)->UIViewController? {
        return UIStoryboard(name: name.description, bundle: nil).instantiateViewController(identifier: idf.description)
    }
}
