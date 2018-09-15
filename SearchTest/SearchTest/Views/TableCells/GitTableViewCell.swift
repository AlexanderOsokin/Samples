//
//  LinkTableVIewCell.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

public class GitTableViewCell: UITableViewCell {
    
	@IBOutlet weak var picture: UIImageView!
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var btnLink: UIButton!

	weak var viewModel: GitItemViewModel? {
		didSet{
			title.text = viewModel?.model.login
			btnLink.titleLabel?.text = viewModel?.model.url
			viewModel?.requestImage { [weak self] imageData, imageUrl in
				guard let modelUrl = self?.viewModel?.model.image, imageUrl == modelUrl else { return }
				DispatchQueue.main.async { [weak self] in
					self?.picture.image = UIImage.init(data: imageData)
				}
			}
		}
	}
}

extension GitTableViewCell: Configurable {
    func setViewModel(model: SearchItemViewModel) {
		self.viewModel = model as? GitItemViewModel
    }
}
