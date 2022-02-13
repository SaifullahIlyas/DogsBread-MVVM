//
//  ShowLoader.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit

protocol ShouldShowLoader  {
    var showLoader : Bool {get set}
    func showLoader(shouldShow:Bool)
}
protocol DisplayAppActivityIndicatorOnVC {
    
}
extension DisplayAppActivityIndicatorOnVC where Self : UIViewController {
     func toggleLoader(shouldShould : Bool){
        if shouldShould {
            AppActivityIndicator.showProgressOnViewVC(vc: self)
        }
        else {
           AppActivityIndicator.hideProgress()
        }
    }
}
