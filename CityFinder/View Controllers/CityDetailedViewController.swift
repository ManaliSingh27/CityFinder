//
//  CityDetailedViewController.swift
//  CityFinder
//
//  Created by Manali Mogre on 31/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import UIKit
import MapKit

class CityDetailedViewController: UIViewController {
    
    @IBOutlet weak var cityMapView: MKMapView!
    var selectedCityViewModel: CityViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCityViewModel.cityName
        cityMapView.setCenterLocation(location: selectedCityViewModel.cityLocation, regionRadius: 1000)
        cityMapView.setAnnotation(title: selectedCityViewModel.cityName, coordinate: selectedCityViewModel.cityLocationCoordinate)
       
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
