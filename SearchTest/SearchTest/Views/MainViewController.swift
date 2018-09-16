//
//  MasterViewController.swift
//  SearchTest
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
	func imageSelected(image: UIImage)
	func linkCLicked(url: String?)
	func handleError(description: String)
}

protocol ImageCellDelegate: AnyObject {
	func imageSelected(imageView: UIImageView, frame: CGRect)
}

class MainViewController: UITableViewController {

    public var viewModel: MainViewControllerViewModel!
    {
        didSet {
			if let oldVal = oldValue {
				oldVal.delegate = nil
			}
         	viewModel.delegate = self
			viewModel.currentSource = .itunes;
        }
    }

	let searchController = UISearchController(searchResultsController: nil)
 
	weak var delegate: MainViewControllerDelegate?

	private func registerCells() {
		let allCells = SearchItemCellType.toStringArray()
		for cell in allCells {
			tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		registerCells()
		self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = false
        searchController.dimsBackgroundDuringPresentation = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.hasItems ? 1 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        let identifier = cellViewModel.cellIdentifier(atIndex: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        guard let configurableCell = cell as? Configurable else {return cell}
		configurableCell.setViewModel(model: cellViewModel, mainDelegate: delegate!, cellDelegate: self)
        return cell
    }

	override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
		return CGFloat(cellViewModel.cellHeight);
	}

	@IBAction func sourceChanged(_ sender: UISegmentedControl, forEvent event: UIEvent) {
		viewModel.currentSource =  sender.selectedSegmentIndex == 0 ? .itunes : .github
	}

	var selectedImageView: UIImageView! = nil
	var selectedFrame: CGRect = CGRect.zero
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.search(query: searchController.searchBar.text!, sourceType: .github)
    }
}

extension MainViewController: TableViewModelDelegate {
    func dataChanged() {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadData()
		}
    }
	func error(description: String) {
		self.delegate?.handleError(description: description)
	}
}

extension MainViewController: ImageCellDelegate {

	func imageSelected(imageView: UIImageView, frame: CGRect) {
		selectedImageView = imageView
		selectedFrame = frame
		delegate?.imageSelected(image: imageView.image!)
	}

}

extension MainViewController: ZoomAnimatorDelegate {
	func transitionWillStartWith(zoomAnimator: ZoomAnimator) {

	}

	func transitionDidEndWith(zoomAnimator: ZoomAnimator) {
		/*let cell = self.collectionView.cellForItem(at: self.selectedIndexPath) as! PhotoCollectionViewCell

		let cellFrame = self.collectionView.convert(cell.frame, to: self.view)

		if cellFrame.minY < self.collectionView.contentInset.top {
			self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .top, animated: false)
		} else if cellFrame.maxY > self.view.frame.height - self.collectionView.contentInset.bottom {
			self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .bottom, animated: false)
		}*/
	}

	func referenceImageView(for zoomAnimator: ZoomAnimator) -> UIImageView? {
		return selectedImageView
	}

	func referenceImageViewFrameInTransitioningView(for zoomAnimator: ZoomAnimator) -> CGRect? {

		let frame = tableView.convert(selectedFrame, to: self.view)
		return frame
	}
}
