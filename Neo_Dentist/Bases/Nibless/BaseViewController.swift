//
//  NiblessViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import UIKit

enum NavbarPosition {
    case left, right
}

class BaseViewController: UIViewController {
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.heart_icon_selected(), for: .selected)
        button.setImage(R.image.heart_icon_unselected(), for: .normal)
        button.backgroundColor = R.color.blue_light()?.withAlphaComponent(0.2)
        button.layer.cornerRadius = 16
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported")
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
      message: "Loading this view controller from a nib is unsupported"
    )
    
    required init?(coder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @objc func likeButtonTapped() {
        likeButton.isSelected.toggle()
    }
    
    func showAlertMessage(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: handler)
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(action)
        navigationController?.pushViewController(alertVC, animated: true)
    }
    
}

extension BaseViewController {
    func setTitle(text: String) {
        navigationItem.title = text
    }
    
    func setBackButton() {
        let backButtonItem = UIBarButtonItem(image: R.image.back_button()?.withRenderingMode(.alwaysOriginal),
                                             style: .plain,
                                             target: self, action: #selector(navigateBack))
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    func setRightButton() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        let rightButtonItem = UIBarButtonItem(customView: likeButton)
        rightButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        rightButtonItem.customView?.heightAnchor.constraint(equalToConstant: 32).isActive = true
        rightButtonItem.customView?.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    func setTitleToLeft(_ text: String) {
        let label = UILabel()
        label.text = text
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        let leftBarButton = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
