//
//  CityListTableViewController.swift
//  CityFinder
//
//  Created by Manali Mogre on 28/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import UIKit

class CityListTableViewController: UITableViewController {
    
    private var cityListViewModel: CityListViewModel!
    private var selectedCityViewModel: CityViewModel!
    
    let searchController = UISearchController(searchResultsController: nil)
    let activityIndicator = UIActivityIndicatorView()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityListViewModel = CityListViewModel(delegate: self, filteredCityDelegate: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        self.setUpSearchController()
        self.setActivityIndicator()
        self.showCitiesList()
    }
    
    /// Gets the Cities list from CityListViewModel
    private func showCitiesList() {
        let dispatchQueue = DispatchQueue(label: "GetCitiesQueue", qos: .background)
        dispatchQueue.async {[weak self] in
            guard let self = self else { return }
            self.cityListViewModel.getCitiesList()
        }
    }
    
    /// Configures the Activity Indicator
    private func setActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
        self.showActivityIndicatory(activityIndicator: activityIndicator)
    }
    
    /// Configures Search Controller
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.kSearchPlaceholderString
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: CityDetailedViewController? = segue.destination as? CityDetailedViewController
        destinationVC!.selectedCityViewModel = selectedCityViewModel!
    }
}

extension CityListTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityListViewModel.numberOfCities(isFiltering: isFiltering)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableViewCell)!
        let cityViewModel: CityViewModel = self.cityListViewModel.cityAtIndex(isFiltering: isFiltering, index: indexPath.row)
        cell.configureCell(viewModel: cityViewModel)
        return cell
    }
}

extension CityListTableViewController {
    // MARK: - Table view delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCityViewModel = self.cityListViewModel.cityAtIndex(isFiltering: isFiltering, index: indexPath.row)
        performSegue(withIdentifier: StoryboardConstants.kCityDetailedSegue, sender: nil)
    }
}

// MARK: - Parser Delegate Methods
extension CityListTableViewController: CityListViewModelDelegate {
    /// Reloads table view on success of Parsing
    func parseCitiesSuccess() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.removeActivityIndicator(activityIndicator: self.activityIndicator)
            let searchBar = self.searchController.searchBar
            if self.isFiltering {
            self.cityListViewModel.filterCities(searchedText: searchBar.text!)
            }
        }
    }
    
    /// Shows Alert if the parsing failed
    func parseCitiesFailureWithMessage(message: String) {
        self.showAlert(title: ErrorConstants.kError, message: message)
    }
}

// MARK: - Filter Delegate methods
extension CityListTableViewController: FilteredCityViewModelDelegate {
    /// Reloads table view on filter success
    func citiesFilteredSuccess() {
        self.tableView.reloadData()
    }
}

extension CityListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        cityListViewModel.filterCities(searchedText: searchBar.text!)
    }
}
