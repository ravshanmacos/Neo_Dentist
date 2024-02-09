//
//  SingleActionSheetViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/01/24.
//

import UIKit
import PanModal

class SingleActionSheetViewController: BaseViewController, SingleActionSheetProtocol {
    
    //MARK: Properties
    var sheetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var sheetLabel: UILabel = {
        let label = NDLabel()
        label.largeTitle2Semibold()
        return label
    }()
    
    var sheetFirstActionButton: UIButton = {
        let button = NDMainButton()
        button.isEnabled = true
        return button
    }()
    
    private let rootView: BaseView = {
       let view = BaseView()
        view.backgroundColor = .white
        return view
    }()
    
    var actionTapped: (() -> Void)?
    
    //MARK: Methods
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        rootView.contentView.addSubviews(sheetImageView, sheetLabel, sheetFirstActionButton)
        sheetImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        sheetLabel.snp.makeConstraints { make in
            make.top.equalTo(sheetImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        sheetFirstActionButton.snp.makeConstraints { make in
            make.top.equalTo(sheetLabel.snp.bottom).offset(42)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    private func configureUI() {
        sheetFirstActionButton.addTarget(self, action: #selector(sheetFirstActionTapped), for: .touchUpInside)
    }
    
    @objc private func sheetFirstActionTapped() {
        dismiss(animated: true)
        actionTapped?()
    }
}

extension SingleActionSheetViewController: PanModalPresentable {
    var panScrollable: UIScrollView?{
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(250)
    }
}
