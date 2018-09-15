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
 
    public weak var delegate: MainViewControllerDelegate?

	private func registerCells() {
		let allCells = SearchItemCellType.toStringArray()
		for cell in allCells {
			tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		registerCells()


        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
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
        configurableCell.setViewModel(model: cellViewModel)
        return cell
    }

	override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
		return CGFloat(cellViewModel.cellHeight);
	}

	@IBAction func sourceChanged(_ sender: UISegmentedControl, forEvent event: UIEvent) {
		if sender.selectedSegmentIndex == 0 {
			viewModel.currentSource = .itunes
		}
		else {
			viewModel.currentSource = .github
		}
	}
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
}

