//
//  ConfigurableCell.swift
//  SearchTest
//
//  Created by Edu user on 15/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

protocol Configurable {
	func setViewModel(model: SearchItemViewModel, mainDelegate: MainViewControllerDelegate, cellDelegate: ImageCellDelegate)
}
