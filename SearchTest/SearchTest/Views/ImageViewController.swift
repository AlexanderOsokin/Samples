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
    
    public weak var delegate: ImageViewControllerDelegate?

	private weak var image: UIImage!;

    public func SetImage(image: UIImage)
    {
		self.image = image
    }
	
	func addTapRecognizer() {
		let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
		self.imageView.addGestureRecognizer(tapRecognizer)
	}

	@objc func didTapImage() {
		delegate?.close()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		addTapRecognizer()
	}

	override func viewWillAppear(_ animated: Bool) {
		UIView.transition(with: imageView, duration: 1, options: [.curveEaseIn], animations: {
			[unowned self] in
			self.imageView.image = self.image
			}, completion: nil)
	}

}

