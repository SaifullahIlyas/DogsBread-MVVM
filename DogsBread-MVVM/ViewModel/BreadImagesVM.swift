//
//  BreadImagesVM.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Foundation
import Combine

class BreadImagesVM : NSObject,NeedsDogBreadImages,GCDWrapper,ShouldShowLoader {
   @Published var showLoader: Bool = false
    
    let breadName : String
    @Published var breadImages : [DogBreadImageVM] = []
    override init() {
        self.breadName  = ""
    }
    init(breadName : String) {
        self.breadName = breadName
    }
    func loadDataForView() {
        runOnBackground {[weak self ] in
            guard let self = self else {return}
            self.showLoader(shouldShow: true)
            let images = self.fetchImages(forBread: self.breadName)
            self.showLoader(shouldShow: false)
            self.updateBreadImages(images: images)
        }
        
    }
    

}
//MARK:- CollectionView Configuration
extension BreadImagesVM {
    func numberOfRowsInSection(section : Int)->Int {
        switch section {
        case BreadImagesCollectionSection.image.rawValue:
            return breadImages.count
        default:
            return 0
        }
    }
    func viewModel(atIndex index : Int)->DogBreadImageVM{
     return breadImages[index]
    }
}
//MARK:- ViewModel
extension BreadImagesVM {
  func  viewModel(atIndex index : Int)-> PreviewVM {
    return PreviewVM(url: breadImages[index].url)
    }
}

//MARK:- Mutability
 extension BreadImagesVM {
    private func updateBreadImages(images : [DogBreadImageVM]){
        self.breadImages = images
    }
    func showLoader(shouldShow: Bool) {
        self.showLoader = shouldShow
    }
}
enum BreadImagesCollectionSection : Int,CaseIterable {
    case image
    var cellIdentifier : String {
        switch self {
        case .image:
            return "DogBreadImageCell"
            
        }
    }
    
}
