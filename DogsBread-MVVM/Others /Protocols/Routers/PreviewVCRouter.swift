//
//  PreviewVCRouter.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 13/02/2022.
//

import UIKit

protocol PreviewVCRouter: InstantiateFromStoryBoard,ViewRouter {
    
}
extension PreviewVCRouter where Self  : UIViewController {
    func route(fromVC VC: UIViewController, withVM VM: PreviewVM) {
        guard let previewVC = self.instance(usingStoryboard: .MAIN, andIdentifier: .PreviewVC) as? PreviewVC else {return}
        previewVC.viewModel = VM
        VC.navigationController?.pushViewController(previewVC, animated: true)
    }
}
