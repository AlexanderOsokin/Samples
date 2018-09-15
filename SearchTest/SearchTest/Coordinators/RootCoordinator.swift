//
//  RootCoordinator.swift
//  SearchTest
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

public protocol RootViewControllerProvider: AnyObject{
    var rootViewController: UIViewController { get }
}

public typealias RootCoordinator = Coordinator & RootViewControllerProvider
