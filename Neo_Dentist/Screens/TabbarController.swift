//
//  TabbarController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/01/24.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case firstTab
    case secondTab
    case thirdTab
    case fourthTab
}

class TabbarController: UITabBarController {
    
    //MARK: Properties
    private let mainScreenViewController: MainScreenViewController
    private let makeAppointmentViewController: AppointmentDetailsViewController
    private let appointmentHistoriesViewController: AppointmentHistoriesViewController
    private let userProfileViewController: UserProfileViewController
    
    //MARK: Methods
    init(mainScreenViewController: MainScreenViewController,
         makeAppointmentViewController: AppointmentDetailsViewController,
         appointmentHistoriesViewController: AppointmentHistoriesViewController,
         userProfileViewController: UserProfileViewController) {
        self.mainScreenViewController = mainScreenViewController
        self.makeAppointmentViewController = makeAppointmentViewController
        self.appointmentHistoriesViewController = appointmentHistoriesViewController
        self.userProfileViewController = userProfileViewController
        super.init(nibName: nil, bundle: nil)
        setTabbarAppearance()
        configureController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureController() {
        let controllers: [UINavigationController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(rootViewController: getController(for: tab))
            controller.tabBarItem.image = Images.TabBar.normalImage(for: tab)
            controller.tabBarItem.selectedImage = Images.TabBar.selectedImage(for: tab)?.withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.tag = tab.rawValue
            return controller
        }
        setViewControllers(controllers, animated: true)
    }
    
    private func getController(for tab: Tabs) -> BaseViewController {
        switch tab {
        case .firstTab: return mainScreenViewController
        case .secondTab: return makeAppointmentViewController
        case .thirdTab: return appointmentHistoriesViewController
        case .fourthTab: return userProfileViewController
        }
    }
    
    private func setTabbarAppearance() {
        let positionOnX: CGFloat = 5
        let positionOnY: CGFloat = 6
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height
        
        let roundLayer = CAShapeLayer()
        let rect = CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height)
        let bezeirPath = UIBezierPath(roundedRect: rect,
                                      cornerRadius: height/2)
        roundLayer.path = bezeirPath.cgPath
        roundLayer.strokeColor = R.color.gray_light()?.cgColor
        roundLayer.lineWidth = 1
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = R.color.bck_color()?.cgColor
        //tabBar.tintColor =
        tabBar.unselectedItemTintColor = R.color.blue_disabled2()
    }
}

extension TabbarController {
    func switchToTab(tab: Tabs) {
        selectedIndex = tab.rawValue
    }
}
