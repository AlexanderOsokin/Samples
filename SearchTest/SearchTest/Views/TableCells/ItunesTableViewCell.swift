//
//  DetailTableViewCell.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

public class ItunesTableViewCell: UITableViewCell {

	@IBOutlet weak var picture: UIImageView! {
		didSet {
			addTapRecognizer()
		}
	}
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var author: UILabel!

	func addTapRecognizer() {
		let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
		self.picture.addGestureRecognizer(tapRecognizer)
	}

	weak var viewModel: ItunesItemViewModel? {
		didSet{
			title.text = viewModel?.model.title
			author.text = viewModel?.model.author
			viewModel?.requestImage { [weak self] imageData, imageUrl in
				guard let modelUrl = self?.viewModel?.model.image, imageUrl == modelUrl else { return }
				DispatchQueue.main.async { [weak self] in
					self?.picture.image = UIImage.init(data: imageData)
				}
			}
		}
	}
	weak var delegate: MainViewControllerDelegate?

	@objc func didTapImage() {
		delegate?.imageSelected(image: picture.image!)
	}

}

extension ItunesTableViewCell: Configurable {
	func setViewModel(model: SearchItemViewModel, mainDelegate: MainViewControllerDelegate) {
		self.viewModel = model as? ItunesItemViewModel
		self.delegate = mainDelegate
	}
}



