//
//  AppCoordinator.swift
//  SearchTest
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit
import  SafariServices

class AppCoordinator: RootCoordinator{
    
    var services: Services
    var childCoordinators: [Coordinator] = []
	var mainController: MainViewController!
    var rootViewController: UIViewController {
        return navigationController
    }
    
    let window: UIWindow
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = false
        return navigationController
    }()
    
    public init(window: UIWindow, services: Services) {
        self.window = window
        self.services = services
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func Start() {
		mainController = MainViewController.fromStoryboard()
        let gitSource = GitSearchSource(httpClient: services.httpClient)
		let itunesSource = ItunesSearchSource(httpClient: services.httpClient)
		let sources: [SearchSourceType: SearchSource] = [SearchSourceType.itunes: itunesSource, SearchSourceType.github: gitSource]
		let viewModel = MainViewControllerViewModel(searchSources: sources, httpClient: services.httpClient)
        mainController.delegate = self
        mainController.viewModel = viewModel
        navigationController.viewControllers = [mainController]
    }
}

extension AppCoordinator: MainViewControllerDelegate {

	func linkCLicked(url: String?) {
		guard let url = url,
			let urlToOpen = URL(string: url) else {
			return
		}
		let safariController = SFSafariViewController(url: urlToOpen)
		mainController.present(safariController, animated: true, completion: nil)
	}

    func imageSelected(image: UIImage) {
       
        let imageCoordinator = ImageCoordinator(image: image, services: services)
        imageCoordinator.delegate = self
        addChildCoordinator(imageCoordinator)
        imageCoordinator.Start()
		imageCoordinator.transitionController.fromDelegate = mainController
        mainController.present(imageCoordinator.rootViewController, animated: true, completion: nil)
    }

	func handleError(description: String) {
		DispatchQueue.main.async { [unowned self] in
			let vc = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
			vc.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
			self.mainController.present(vc, animated: true, completion: nil)
		}
	}
}

extension AppCoordinator: ImageCoordinatorDelegate {
    
    func didCloseImage(imageCoordinator: ImageCoordinator) {
     removeChildCoordinator(imageCoordinator)
    }
    
    

}
