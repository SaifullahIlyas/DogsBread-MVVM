//
//  AppActivityIndicator .swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit

final public  class AppActivityIndicator {
 private static var shared = AppActivityIndicator()
    lazy var activity : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.startAnimating()
        return activity
    }()
    lazy var activtyPlaceHolderView : UIView = {
       let  placeHolder =  UIView()
        placeHolder.backgroundColor = .black
        placeHolder.layer.cornerRadius = 5
        placeHolder.layer.masksToBounds = true
        return placeHolder
        
    }()
    lazy var  overlayView : UIView = {
        let view =   UIView()
        view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 0.3)
        return view
    }()

  private  init() {
        
    }
    private func instantiate(withFrame frame : CGRect)->UIView{
   let view =  AppActivityIndicator.shared.overlayView
    view.frame = frame
    let placeHolder = AppActivityIndicator.shared.activtyPlaceHolderView
//    let placeholderWidth = 100
//    let placeholderHeight = 100
//    //or can be done by adding autolyaout constraint
//    let placeholderOffSetX = Int(view.center.x) - placeholderWidth/2
//    let placeholderOffSetY = Int(view.center.y) - placeholderHeight/2
//        placeHolder.frame =  CGRect(x: placeholderOffSetX, y: placeholderOffSetY, width: placeholderWidth, height: placeholderHeight)
    let activity =  AppActivityIndicator.shared.activity
    placeHolder.addSubview(activity)
    view.addSubview(placeHolder)
    placeHolder.translatesAutoresizingMaskIntoConstraints = false
    placeHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    placeHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    placeHolder.widthAnchor.constraint(equalToConstant: 100).isActive = true
    placeHolder.heightAnchor.constraint(equalToConstant: 100).isActive = true
    view.layoutIfNeeded()
    activity.frame = placeHolder.bounds
   
    
    return view
    }
   
  public class  func showProgressOnViewVC(vc: UIViewController){
    hideProgress()
    let view = AppActivityIndicator.shared.instantiate(withFrame: vc.view.frame)
    vc.view.addSubview(view)
    }
    public class func hideProgress() {
        let overlay  = AppActivityIndicator.shared.overlayView
        if let _ = overlay.superview {
            overlay.removeFromSuperview()
        }
    }
    
}
