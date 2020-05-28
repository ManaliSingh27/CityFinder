//
//  CityListViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 28/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import UIKit

protocol CityListViewModelDelegate : NSObject
{
    func parseCitiesSuccess()
    func parseCitiesFailureWithMessage(message : String )
}

class CityListViewModel: NSObject {
    
    private var cities : Array<City>{
        didSet
        {
            self.delegate?.parseCitiesSuccess()
        }
    }
    
    weak var delegate : CityListViewModelDelegate?
    
    init(delegate : CityListViewModelDelegate?)
    {
        self.cities = Array<City>()
        self.delegate = delegate
    }
    
    func parseCitiesJson()
    {
        guard
            let path = Bundle.main.path(forResource: "cities", ofType: "json")
            else {
                return
        }
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response = try JSONDecoder().decode([City].self, from: data)
            // Sorting the List alphabetically based on City Name
            self.cities =  response.sorted{$0.cityName < $1.cityName}
        }
        catch 
        {
            self.delegate?.parseCitiesFailureWithMessage(message: "Parsing Failed")
        }
      
    }
    
    func numberOfCities()->Int
    {
        return self.cities.count
    }
    
    func cityAtIndex(index : Int) -> CityViewModel
    {
        return CityViewModel(city: self.cities[index])
    }

}
