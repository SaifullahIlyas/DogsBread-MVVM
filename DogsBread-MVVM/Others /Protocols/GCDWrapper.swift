//
//  GCDWrapper.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation

protocol GCDWrapper {
    
}
extension GCDWrapper where Self : NSObject {
    func runOnBackground(completion : @escaping(()->Void)) {
        let queue = DispatchQueue.global()
        queue.async {
            completion()
        }
    }
}
