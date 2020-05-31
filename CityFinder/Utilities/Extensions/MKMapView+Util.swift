//
//  MKMapView+Util.swift
//  CityFinder
//
//  Created by Manali Mogre on 31/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    func setCenterLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
    
    func setAnnotation(title: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordinate
        addAnnotation(annotation)
    }
    
}
