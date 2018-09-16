//
//  LinkTableVIewCell.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

class GitTableViewCell: UITableViewCell {

	@IBOutlet weak var picture: UIImageView!  {
		didSet {
			addTapRecognizer()
		}
	}

	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var btnLink: UIButton!

	@IBAction func btnLinkClicked(_ sender: UIButton) {
		delegate?.linkCLicked(url: viewModel?.model.url)
	}

	func addTapRecognizer() {
		let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
		self.picture.addGestureRecognizer(tapRecognizer)
	}

	weak var viewModel: GitItemViewModel? {
		didSet{
			title.text = viewModel?.model.login
			//btnLink.titleLabel?.text = viewModel?.model.url
			viewModel?.requestImage { [weak self] imageData, imageUrl in
				guard let modelUrl = self?.viewModel?.model.image, imageUrl == modelUrl else { return }
				DispatchQueue.main.async { [weak self] in
					self?.picture.image = UIImage.init(data: imageData)
				}
			}
		}
	}

	weak var delegate: MainViewControllerDelegate?
	weak var cellDelegate: ImageCellDelegate?

	@objc func didTapImage() {
		if self.picture.image == nil { return }
		cellDelegate?.imageSelected(imageView: self.picture!, frame: self.frame)
	}
}

extension GitTableViewCell: Configurable {
	func setViewModel(model: SearchItemViewModel, mainDelegate: MainViewControllerDelegate, cellDelegate: ImageCellDelegate) {
		self.viewModel = model as? GitItemViewModel
		self.delegate = mainDelegate
		self.cellDelegate = cellDelegate
	}
}


