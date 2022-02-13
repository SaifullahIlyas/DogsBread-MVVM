//
//  BreadListVM.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import UIKit
import Combine
final class BreadListVM : NSObject,ShouldShowLoader, GCDWrapper, NeedsDogsBread{
    @Published var breeds : [DogBreadNameVM] = []
    @Published var showLoader: Bool = false
    
   func loadDataForView() {
    runOnBackground {[weak self] in
        guard let self = self else {return}
        self.showLoader(shouldShow: true)
        let remoteBreads = self.fetchDogsBreads()
        self.showLoader(shouldShow: false)
        self.updateBreads(breadsData: remoteBreads)
    }
    }
}

//MARK:- TableView Configuration
extension BreadListVM {
    func numberOfRowsInSection(section : Int)->Int {
        switch section {
        case BreadsTbwSection.breads.rawValue:
            return breeds.count
        default:
            return 0
        }
    }
    func viewModel(atIndex index : Int)->DogBreadNameVM{
     return breeds[index]
    }
}
//MARK:-ViewModels
extension BreadListVM {
    func viewModel(fromIndex index : Int)->BreadImagesVM {
        return BreadImagesVM(breadName: breeds[index].title)
    }
    
}

//MARK:- Mutabability
 extension BreadListVM {
    private  func updateBreads(breadsData: [DogBreadNameVM]){
        self.breeds = breadsData
    }
    func showLoader(shouldShow: Bool) {
        self.showLoader = shouldShow
    }
}


enum BreadsTbwSection : Int,CaseIterable {
    case breads
    var cellIdentifier : String {
        switch self {
        case .breads:
            return "DogBreadNameCell"
            
        }
    }
    
}
