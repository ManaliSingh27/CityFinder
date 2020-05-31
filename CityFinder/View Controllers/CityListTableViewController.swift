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
    let activityIndicator = UIActivityIndicatorView(style: .medium)

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
        
        self.setUpSearchBar()
        let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
        self.showActivityIndicatory(activityIndicator: activityIndicator)

        dispatchQueue.async {
        self.cityListViewModel.getCitiesList()
        }
    }
    
    private func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Find a City"
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
        performSegue(withIdentifier: "showDetailedCitySegue", sender: nil)
    }
}

extension CityListTableViewController: CityListViewModelDelegate {
    
    func parseCitiesSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.removeActivityIndicator(activityIndicator: self.activityIndicator)
        }
    }
    
    func parseCitiesFailureWithMessage(message: String) {
        self.showError("Error", message: message)
    }
}

extension CityListTableViewController: FilteredCityViewModelDelegate {
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
