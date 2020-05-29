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
    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
           return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cityListViewModel = CityListViewModel(delegate: self, filteredCityDelegate: self)
        self.cityListViewModel.getCitiesList()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? self.cityListViewModel.numberOfFilteredCities() :self.cityListViewModel.numberOfCities()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableViewCell)!
        let cityViewModel: CityViewModel = isFiltering ? self.cityListViewModel.filteredCityAtIndex(index: indexPath.row) :self.cityListViewModel.cityAtIndex(index: indexPath.row)
        cell.configureCell(viewModel: cityViewModel)
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension CityListTableViewController: CityListViewModelDelegate {
    
    func parseCitiesSuccess() {
        self.tableView.reloadData()
    }
    
    func parseCitiesFailureWithMessage(message: String) {
        
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
