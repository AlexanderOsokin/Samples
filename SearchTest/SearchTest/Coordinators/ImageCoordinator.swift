//
//  ImageCoordinator.swift
//  SearchTest
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageCoordinatorDelegate: AnyObject {
    
    func didCloseImage(imageCoordinator: ImageCoordinator)
}

public class ImageCoordinator: RootCoordinator {
    
    public var services: Services
    
    public var childCoordinators: [Coordinator] = []
    
    public func Start() {
        rootController.SetImage(image: image)
    }
    
    public var rootViewController: UIViewController {
        return rootController
    }
    
    private var image: UIImage
    
    private lazy var rootController: ImageViewController = {
        let imageController = ImageViewController.fromStoryboard()
        imageController.delegate = self
        return imageController
    }()
    
    public weak var delegate: ImageCoordinatorDelegate?
    
    public init (image: UIImage, services: Services) {
        self.image = image
        self.services = services
    }
}

extension ImageCoordinator: ImageViewControllerDelegate {
    
    func close() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
}
