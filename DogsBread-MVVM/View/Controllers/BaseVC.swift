//
//  BaseVC.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 13/02/2022.
//

import UIKit

class BaseVC : UIViewController {
    lazy var titleLbl : UILabel  = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(onView: self.view)
        setNavigation()
        setNavbarTitle(title: AppStrings.twoLineAppTitle.localizedValue)
       
    }
   func setBackground(onView view : UIView){
        view.backgroundColor = ThemeColor.appGreenFade.value
    }
    func setNavigation() {
        guard let navbar = navigationController?.navigationBar else {return}
        navbar.barTintColor = ThemeColor.appGreen.value
        navbar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLbl)
    }
    func setNavbarTitle(title : String) {
        titleLbl.text = title
    }
}
