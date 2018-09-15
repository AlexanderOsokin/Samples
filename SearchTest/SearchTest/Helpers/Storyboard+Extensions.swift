//
//  Storyboard+Extensions.swift
//  SearchTest
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func fromStoryboard(name: String = "Main") -> Self {
        return instantiate(name)
    }
    
    fileprivate class func instantiate<T>(_ name: String) -> T {
        let storyBoard = UIStoryboard(name: name, bundle: nil )
        let identifier = String(describing: self)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Unable to instatiate \(identifier) from the storyboard.")
        }
        return vc
    }
}
