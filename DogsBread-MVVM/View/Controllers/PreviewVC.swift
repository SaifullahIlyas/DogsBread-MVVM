//
//  PreviewVC.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 13/02/2022.
//

import UIKit
import Combine

class PreviewVC : BaseVC,Bindable,SubscriptionStore {
    
    lazy var imageVw : ZoomableImageView = {
        let imageView = ZoomableImageView(frame: self.view.frame)
        return imageView
    }()
    var subscriptions: [AnyCancellable] = []
    lazy var viewModel = PreviewVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(onView: view)
        self.view.addSubview(imageVw)
        imageVw.setup()
        self.bind(viewModel: viewModel, toView: self)
        self.viewModel.loadImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationController = self.navigationController else {return}
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navigationController = self.navigationController else {return}
        navigationController.setNavigationBarHidden(false, animated: true)
    }
    override func setBackground(onView view: UIView) {
        view.backgroundColor = ThemeColor.appGreen.value
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func bind(viewModel vm:PreviewVM?, toView view: UIViewController?) {
       
        vm?.$imageData.receive(on: DispatchQueue.main).sink{[weak self] in
            guard let self = self else {return}
            if let image =  UIImage(data: $0){
            self.imageVw.needImagePreview(image: image)
            }
        }.store(in: &subscriptions)
        
    }
    
}

