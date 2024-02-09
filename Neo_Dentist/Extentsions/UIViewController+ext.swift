//
//  UIViewController+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import UIKit
import Combine
import SnapKit

//MARK: Configure View Controller
extension UIViewController {
    func addFullScreen(addViewController child: UIViewController) {
        guard child.parent == nil else { return }
        addChild(child)
        view.addSubview(child.view)
        child.view.snp.makeConstraints{ $0.edges.equalToSuperview() }
        child.didMove(toParent: self)
    }
    
    func removeViewController(childViewController child: UIViewController?) {
        guard let child else { return }
        guard child.parent != nil else { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}

//MARK: Error Messages
extension UIViewController {
    func present(errorMessage: ErrorMessage) {
        let errorAlertController = UIAlertController(title: errorMessage.title,
                                                     message: errorMessage.message,
                                                     preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        errorAlertController.addAction(okAction)
        present(errorAlertController, animated: true, completion: nil)
    }
    
    func present(errorMessage: ErrorMessage,
                 errorPresentation: PassthroughSubject<ErrorPresentation?, Never>) {
        errorPresentation.send(.presenting)
        let errorAlertController = UIAlertController(title: errorMessage.title, message: errorMessage.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            errorPresentation.send(.dismissed)
            errorPresentation.send(nil)
        }
        errorAlertController.addAction(action)
        self.present(errorAlertController, animated: true)
    }
}
