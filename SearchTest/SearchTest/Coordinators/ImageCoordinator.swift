//
//  ImageCoordinator.swift
//  SearchTest
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCoordinatorDelegate: AnyObject {
    
    func didCloseImage(imageCoordinator: ImageCoordinator)
}

class ImageCoordinator: RootCoordinator {
    
	var services: Services
    
	var childCoordinators: [Coordinator] = []
	var transitionController = ZoomTransitionController()

	func Start() {
       rootController.image = self.image
    }
    
	var rootViewController: UIViewController {
        return rootController
    }
    
    private  weak var image: UIImage!
    
    private lazy var rootController: ImageViewController = {
        let imageController = ImageViewController.fromStoryboard()
        imageController.delegate = self
		transitionController.toDelegate = imageController
		imageController.transitioningDelegate = transitionController
        return imageController
    }()
    
    weak var delegate: ImageCoordinatorDelegate?
    
    init (image: UIImage, services: Services) {
        self.image = image
        self.services = services
    }
}

extension ImageCoordinator: ImageViewControllerDelegate {
    
    func close() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
}
