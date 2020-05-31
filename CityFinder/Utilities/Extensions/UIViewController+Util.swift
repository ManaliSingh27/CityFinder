//
//  UIViewController+Util.swift
//  CityFinder
//
//  Created by Manali Mogre on 30/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - Alert Controller
    /// Shows Alert with message and title
    /// - parameter title: Title of Alert
    /// - parameter message: Alert Message
    func showAlert(title: String?, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    // MARK: - Activity Indicator
    /// Shows Activity indicator
    /// - parameter activityIndicator: activity indicator instance
    func showActivityIndicatory(activityIndicator: UIActivityIndicatorView) {
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.frame = view.bounds
        activityIndicator.color = Constants.blueColor
        activityIndicator.bringSubviewToFront(self.view)
        activityIndicator.startAnimating()
    }
    
    /// Shows Activity indicator
    /// - parameter activityIndicator: activity indicator instance
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
