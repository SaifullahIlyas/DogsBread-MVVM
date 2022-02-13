//
//  BreadImagesVC.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//
import UIKit
import Combine

class BreadImagesVC : BaseVC,Bindable,SubscriptionStore,DisplayAppActivityIndicatorOnVC ,PreviewVCRouter{
    var subscriptions: [AnyCancellable] = []
    @IBOutlet weak var collectionView : UICollectionView?{
        didSet {
            self.collectionView?.collectionViewLayout = GridFlowLayout(numberOfColumns: 3, horizonatalSpacing: 2, verticalSpacing: 2)
            self.collectionView?.backgroundView = nil
            self.collectionView?.backgroundColor = .clear
            self.collectionView?.delegate = self
            self.collectionView?.dataSource = self
           
        }
    }
    lazy var viewModel : BreadImagesVM = {
        return BreadImagesVM()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadDataForView()
        bind(viewModel: viewModel, toView: self)
        
    }
    func bind(viewModel vm: BreadImagesVM?, toView view: BreadImagesVC?) {
        vm?.$breadImages.receive(on: DispatchQueue.main).sink{[weak self ] _ in
            guard let self = self ,let collectionView = self.collectionView else {return}
            collectionView.reloadData()
        }.store(in: &subscriptions)
       vm?.$showLoader.receive(on: DispatchQueue.main).sink{[weak self] in 
        guard let self = self else {return}
        self.toggleLoader(shouldShould: $0)
       }.store(in: &subscriptions)
    }
    deinit {
        print("Deinit")
        subscriptions.removeAll()
    }
}

extension BreadImagesVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case BreadImagesCollectionSection.image.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreadImagesCollectionSection.image.cellIdentifier,for: indexPath) as? DogBreadImageCell else {return UICollectionViewCell(frame: .zero)}
            cell.updateCell(withVM: viewModel.viewModel(atIndex: indexPath.row))
            return cell
        default:
            return UICollectionViewCell(frame: .zero)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.route(fromVC: self, withVM: viewModel.viewModel(atIndex: indexPath.row))
    }
}
