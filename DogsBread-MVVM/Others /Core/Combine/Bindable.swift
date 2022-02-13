//
//  Bindable.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit

protocol Bindable {
    associatedtype BindingVM = AnyObject
    associatedtype BindingVC = UIViewController
    func bind(viewModel vm :BindingVM?,toView view :BindingVC?)
}
