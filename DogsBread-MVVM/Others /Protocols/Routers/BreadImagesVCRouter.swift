//
//  BreadImagesVCRouter.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit
protocol ViewRouter {
    associatedtype RouterVC = UIViewController
    associatedtype RouterVM = UIViewController
    func route(fromVC VC : RouterVC, withVM VM : RouterVM)

}
protocol BreadImagesVCRouter: InstantiateFromStoryBoard,ViewRouter {
    
}
extension BreadImagesVCRouter where Self  : UIViewController {
    func route(fromVC VC: UIViewController, withVM VM: BreadImagesVM) {
        guard let breadImagesVC = self.instance(usingStoryboard: .MAIN, andIdentifier: .BreadImagesVC) as? BreadImagesVC else {return}
        breadImagesVC.viewModel = VM
        VC.navigationController?.pushViewController(breadImagesVC, animated: true)
    }
}

