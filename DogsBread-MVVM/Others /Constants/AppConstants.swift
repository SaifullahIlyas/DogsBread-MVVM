//
//  AppConstants.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit

enum  Storyboards : CustomStringConvertible {
    case MAIN
    var description: String {
        switch self {
        case .MAIN:
            return  "Main"
        
        }
    }
}
enum  ViewControllerIdentifier : CustomStringConvertible {
    case BreadImagesVC
    case PreviewVC
    var description: String {
        switch self {
        case .BreadImagesVC:
            return  "BreadImagesVC"
        case .PreviewVC:
            return "PreviewVC"
        
        }
    }
}
 enum ThemeColor {
    case appGreen
    case appGreenFade
    var value : UIColor {
        switch self {
        case .appGreen:
            return #colorLiteral(red: 0.09019607843, green: 0.6823529412, blue: 0.3607843137, alpha: 1)
        case .appGreenFade :
            return #colorLiteral(red: 0.4196078431, green: 0.8117647059, blue: 0.5803921569, alpha: 1)
          
    }
    }
}
enum AppStrings {
    case twoLineAppTitle
    var localizedValue : String {
        switch self {
        case .twoLineAppTitle:
            return  "Dog\nBread.".localized
        }
    }
    
   
    
}
extension String {
    var localized : String {
        return NSLocalizedString(self, comment: self)
    }
}

