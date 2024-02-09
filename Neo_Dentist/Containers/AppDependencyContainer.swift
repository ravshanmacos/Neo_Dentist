//
//  AppDependencyContainer.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

class AppDependencyContainer {
    
    //MARK: Properties
    let sharedUserSessionRepository: UserSessionRepository
    let sharedMainViewModel: MainManagerViewModel
    
    //MARK: Methods
    init() {
        func makeUserSessionRepository() -> UserSessionRepository {
            let dataStore = makeUserSessionDataStore()
            let remoteAPI = makeAuthRemoteAPI()
            return NeoDentistUserSessionRepository(dataStore: dataStore, remoteAPI: remoteAPI)
        }
        
        func makeUserSessionDataStore() -> UserSessionDataStore {
            let coder = makeUserSessionCoder()
            return KeychainUserSessionDataStore(userSessionCoder: coder)
        }
        
        func makeUserSessionCoder() -> UserSessionCoding {
            return UserSessionPropertyListCoder()
        }
        
        func makeAuthRemoteAPI() -> AuthRemoteAPI {
            return FakeAuthRemoteAPI()
        }
        
        func makeMainViewModel() -> MainManagerViewModel {
            return MainManagerViewModel()
        }
        
        self.sharedUserSessionRepository = makeUserSessionRepository()
        self.sharedMainViewModel = makeMainViewModel()
    }
    
    func makeMainViewController() -> MainManagerViewController {
        let launchViewController = makeLaunchViewController()
        
        let onboardingViewControllerFacotory = {
            return self.makeOboardingViewController()
        }
        
        let signedInViewControllerFactory = { (userSession: UserSession) in
            self.makeSignedInViewController(userSession: userSession)
        }
        
        return MainManagerViewController(viewModel: sharedMainViewModel,
                                  launchViewController: launchViewController,
                                  onboardingViewControllerFactory: onboardingViewControllerFacotory,
                                  signedInViewControllerFactory: signedInViewControllerFactory)
    }
    
    
    //MARK: Launching
    func makeLaunchViewController() -> LaunchViewController {
        return LaunchViewController(launchViewModelFactory: self)
    }
    
    func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel(userSessionRepository: sharedUserSessionRepository,
                               notSignedInResponder: sharedMainViewModel,
                               signedInResponder: sharedMainViewModel)
    }
    
    //Onboarding
    func makeOboardingViewController() -> OnboardingViewController {
        let dependencyContainer = makeOnboardingDependencyContainer()
        return dependencyContainer.makeOnboardingViewController()
    }
    
    func makeOnboardingDependencyContainer() -> OnboardingDependencyContainer {
        return OnboardingDependencyContainer(appDependencyContainer: self)
    }
    
    //Signed In
    func makeSignedInDependencyContainer(userSession: UserSession) -> SignedInDependencyContainer {
        return SignedInDependencyContainer(userSession: userSession, appDependencyContainer: self)
    }
    
    func makeSignedInViewController(userSession: UserSession) -> TabbarController {
        let dependencyContainer = makeSignedInDependencyContainer(userSession: userSession)
        return dependencyContainer.makeTabBarViewController()
    }
}

extension AppDependencyContainer: LaunchViewModelFactory {}
