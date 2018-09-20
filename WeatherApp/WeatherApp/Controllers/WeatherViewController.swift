//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Volodymyr Gnatiuk on 20.09.18.
//  Copyright © 2018 openweather. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noSearchResultsLabel: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private let viewModel: WeatherViewModelProtocol = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
    }
    
    func configureSearchBar() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        searchBar.becomeFirstResponder()
    }
    
    func loadData() {
        viewModel.loadData({ [weak self] updateUI in
            if updateUI {
                self?.updateUI()
            }
        }) { [weak self] error in
            self?.updateUI(error)
        }
    }

    private  func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 140
        tableView.showsVerticalScrollIndicator = true
    }
    
    private func updateUI(_ error: Error? = nil) {
        if let _ = error {
            noSearchResultsLabel.isHidden = false
            tableView.isHidden = true
            return
        }
        if dataSource().days.count == 0 {
            noSearchResultsLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noSearchResultsLabel.isHidden = true
            tableView.reloadData()
            scrollToTop()
            tableView.isHidden = false
        }
    }
    
    private func scrollToTop() {
        if dataSource().days.count > 0 {
            let topIndex = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndex, at: .top, animated: false)
        }
    }
    
    private func dataSource() -> ForecastModel {
        return viewModel.forecast
    }
}

// MARK: - UITableViewDataSource

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource().days.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayWeatherCell.Key) as! DayWeatherCell
        cell.dayForecast = viewModel.forecast.days[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource().days.count > 0 && dataSource().days.count == indexPath.row {
            if viewModel.isLoading == false {
                loadData()
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, viewModel.queryModel.city != searchBar.text {
            viewModel.queryModel.city = text
            loadData()
        }
        searchBar.resignFirstResponder()
    }
}
