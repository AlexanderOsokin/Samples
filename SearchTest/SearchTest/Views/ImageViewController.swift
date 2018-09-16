//
//  DetailViewController.swift
//  SearchTest
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import UIKit

protocol ImageViewControllerDelegate: AnyObject {
    func close()
}

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
	weak var delegate: ImageViewControllerDelegate?
	weak var image: UIImage!

	func addTapRecognizer() {
		let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
		self.imageView.addGestureRecognizer(tapRecognizer)
	}

	@objc func didTapImage() {
		delegate?.close()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		imageView.image = image
		addTapRecognizer()
	}
}

extension ImageViewController: ZoomAnimatorDelegate {

	func transitionWillStartWith(zoomAnimator: ZoomAnimator) {
	}

	func transitionDidEndWith(zoomAnimator: ZoomAnimator) {
	}

	func referenceImageView(for zoomAnimator: ZoomAnimator) -> UIImageView? {
		return self.imageView
	}

	func referenceImageViewFrameInTransitioningView(for zoomAnimator: ZoomAnimator) -> CGRect? {
		return self.imageView.frame
	}
}


