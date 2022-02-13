//
//  SubscriptionStore.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Combine

protocol SubscriptionStore : AnyObject {
    var subscriptions : [AnyCancellable] {get set}
}
extension SubscriptionStore {
}
