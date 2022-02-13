//
//  Cells.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit
class DogBreadNameCell : UITableViewCell {
    @IBOutlet weak var  nameLbl : UILabel?
    @IBOutlet weak var placeHolderView : UIView?
    override func awakeFromNib() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.placeHolderView?.layer.cornerRadius = 10
        self.placeHolderView?.layer.masksToBounds = true
        
    }
    func updateCell(withVM vm : DogBreadNameVM){
        nameLbl?.text = vm.title
    }
}
class DogBreadImageCell : UICollectionViewCell {
    @IBOutlet weak var  imgVw : UIImageView?
    override func awakeFromNib() {
        
    }
    func updateCell(withVM vm : DogBreadImageVM){
        ImageDownLoader.image(fromURL: vm.url) {[weak self] image,_ in
            DispatchQueue.main.async {
                self?.imgVw?.image = image
            }
        }
    }
}

