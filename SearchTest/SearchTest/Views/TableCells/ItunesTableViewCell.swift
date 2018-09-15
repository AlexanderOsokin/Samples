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

	@IBOutlet weak var picture: UIImageView!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var author: UILabel!
	
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
}

extension ItunesTableViewCell: Configurable {
	func setViewModel(model: SearchItemViewModel) {
		self.viewModel = model as? ItunesItemViewModel
	}
}
