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
    
    public func SetImage(image: UIImage)
    {
        UIView.transition(with: imageView, duration: 1, options: [.curveEaseIn], animations: {
            [unowned self] in
            self.imageView.image = image
        }, completion: nil)
    }
    /*
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
*/

}

