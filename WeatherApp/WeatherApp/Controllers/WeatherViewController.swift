//
//  WeatherViewController.swift
//  GYGtest
//
//  Created by Hnatiuk, Volodymyr on 25.08.18.
//  Copyright © 2018 GYG. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherViewControllerProtocol {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noSearchResultsLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton!
    @IBOutlet private weak var sortDirectionIcon: UIImageView!
    
    private let viewModel = WeatherViewModel()
    weak var delegate: WeatherViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData(initial: true)
    }
    
    func loadData(initial: Bool = false) {
        if initial {
            viewModel.resetRequest()
            tableView.reloadData()
        }
        viewModel.searchForNextPage(initial: initial).done { [weak self] updateUI in
            if updateUI {
                self?.updateUI(initial)
            }
        }.catch { [weak self] (error) in
            self?.updateUI(initial)
        }
    }

    private  func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = true
    }
    
    private func updateUI(_ initial: Bool = false) {
        if dataSource().count == 0 {
            noSearchResultsLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noSearchResultsLabel.isHidden = true
            tableView.reloadData()
            if initial {
                scrollToTop()
            }
            tableView.isHidden = false
        }
    }
    
    private func scrollToTop() {
        if dataSource().count > 0 {
            let topIndex = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndex, at: .top, animated: false)
        }
    }
    
    private func dataSource() -> [ReviewModel] {
        return viewModel.searchReviews
    }
    
    @IBAction func sortButtonAction(_ sender: UIButton) {
        let newDirection = self.viewModel.queryModel.sortDirection.invert()
        self.viewModel.queryModel.sortDirection = newDirection
        self.sortDirectionIcon.image = UIImage(named: newDirection.assetName())
        self.loadData(initial: true)
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let loadingCell = viewModel.queryModel.pagination.isLastPage() ? 0 : 1
        return dataSource().count == 0 ? 0 : dataSource().count + loadingCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataSource().count > 0 && dataSource().count == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell") as! LoadingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
            cell.data = viewModel.searchReviews[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource().count > 0 && dataSource().count == indexPath.row {
            if viewModel.isLoading == false {
                loadData()
            }
        }
    }
}

