//
//  LikedDoctorsViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit
import Combine

protocol LikedDoctorsListViewModelFactory {
    func makeLikedDoctorsListViewModel() -> LikedDoctorsListViewModel
}

class LikedDoctorsListViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: LikedDoctorsListViewModelFactory
    private let viewModel: LikedDoctorsListViewModel
    private let rootView: LikedDoctorsListRootView
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModelFactory: LikedDoctorsListViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeLikedDoctorsListViewModel()
        self.rootView = LikedDoctorsListRootView(viewModel: viewModel)
        super.init()
        bindTwoActionSheet()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(text: "Избранные доктора")
        setBackButton()
    }
}

//MARK: Navigations

private extension LikedDoctorsListViewController {
    func bindTwoActionSheet() {
        /*
         viewModel
             .$openDeleteActionPanModal
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 let sheetVC = TwoActionSheetViewController()
                 sheetVC.sheetImageView.image = R.image.broken_heart()
                 sheetVC.sheetLabel.text = "Вы уверены, что хотите удалить этого \nдоктора из раздела “Избранные \nдоктора”?"
                 sheetVC.sheetFirstActionButton.setTitle("Удалить", for: .normal)
                 sheetVC.sheetSecondActionButton.setTitle("Отмена", for: .normal)
                 sheetVC.firstActionTapped = {[weak self] in
                     guard let self else { return }
                     self.viewModel.likeDoctor(isFavorite: false)
                 }
                 sheetVC.secondActionTapped = {[weak self] in
                         guard let self else { return }
                     self.dismiss(animated: true)
                 }
                 navigationController?.presentPanModal(sheetVC)
             }.store(in: &subscriptions)
         */
    }
}
