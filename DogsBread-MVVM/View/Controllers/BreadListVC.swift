//
//  Controller.swift
//  DogsBread-MVVM
//
//  Created by Saifullah Ilyas on 12/02/2022.
//

import Combine
import UIKit

class BreadListVC : BaseVC,SubscriptionStore,Bindable,BreadImagesVCRouter,DisplayAppActivityIndicatorOnVC{
    var subscriptions: [AnyCancellable] = []
    @IBOutlet var tableView : UITableView?{
        didSet{
            self.tableView?.estimatedRowHeight = 500
            
            self.tableView?.rowHeight = UITableView.automaticDimension
            self.tableView?.backgroundView = nil
            self.tableView?.backgroundColor  = .clear
            self.tableView?.separatorStyle = .none
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
        }
    }
    lazy var viewModel : BreadListVM = {
     return   BreadListVM()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind(viewModel: viewModel, toView: self)
        viewModel.loadDataForView()
    }
    func bind(viewModel vm: BreadListVM?, toView view: BreadListVC?) {
        vm?.$breeds.receive(on: DispatchQueue.main).sink{ _ in
            view?.tableView?.reloadData()
        }.store(in: &subscriptions)
        vm?.$showLoader.receive(on: DispatchQueue.main).sink{view?.toggleLoader(shouldShould: $0)}.store(in: &subscriptions)
        
    }
   
    
}
//MARK:- TableView
extension BreadListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case BreadsTbwSection.breads.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BreadsTbwSection.breads.cellIdentifier) as? DogBreadNameCell else {return UITableViewCell(frame: .zero)}
            cell.updateCell(withVM: viewModel.viewModel(atIndex: indexPath.row))
            return cell
        default:
            return UITableViewCell(frame: .zero)
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.route(fromVC: self, withVM: viewModel.viewModel(fromIndex: indexPath.row))
    }
}
