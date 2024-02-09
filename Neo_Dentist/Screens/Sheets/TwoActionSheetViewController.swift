//
//  TwoActionSheetViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/01/24.
//

import UIKit
import PanModal

class TwoActionSheetViewController: BaseViewController, SingleActionSheetProtocol {
    
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
    
    var sheetFirstActionButton = makeActionButton(titleColor: R.color.red_error(), bckColor: R.color.red_light())
    var sheetSecondActionButton = makeActionButton(titleColor: R.color.blue_dark(), bckColor: R.color.blue_disabled2())
    
    private let hStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let rootView: BaseView = {
       let view = BaseView()
        view.backgroundColor = .white
        return view
    }()
    
    var firstActionTapped: (() -> Void)?
    var secondActionTapped: (() -> Void)?
    
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
        rootView.contentView.addSubviews(sheetImageView, sheetLabel, hStack)
        hStack.addArrangedSubviews(sheetFirstActionButton, sheetSecondActionButton)
        
        sheetImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        sheetLabel.snp.makeConstraints { make in
            make.top.equalTo(sheetImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        hStack.snp.makeConstraints { make in
            make.top.equalTo(sheetLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    private func configureUI() {
        sheetFirstActionButton.addTarget(self, action: #selector(sheetFirstActionTapped), for: .touchUpInside)
        sheetSecondActionButton.addTarget(self, action: #selector(sheetSecondActionTapped), for: .touchUpInside)
    }
    
    @objc private func sheetFirstActionTapped() {
        dismiss(animated: true)
        firstActionTapped?()
    }
    
    @objc private func sheetSecondActionTapped() {
        dismiss(animated: true)
        secondActionTapped?()
    }
}

extension TwoActionSheetViewController: PanModalPresentable {
    var panScrollable: UIScrollView?{
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(280)
    }
}

private extension TwoActionSheetViewController {
    static func makeActionButton(titleColor: UIColor?, bckColor: UIColor?) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = bckColor
        return button
    }
}
