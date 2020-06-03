//
//  ParserViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 29/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation

enum ParserResult<T> {
    case success(T)
    case error(String)
}

protocol ParseData {
      func parseJson(resourceFile: String, completion: @escaping(_ result: ParserResult<[Any]>) -> Void)
}

class ParserViewModel {
    var dataParserObj: ParseData
    
    init(dataParser: ParseData) {
        self.dataParserObj = dataParser
    }
    
    func parseJson(resourceFile: String, completion: @escaping(_ result: ParserResult<[Any]>) -> Void) {
        dataParserObj.parseJson(resourceFile: resourceFile, completion: {(result) in
            completion(result)
        })
    }
}

final class CityParserViewModel: ParseData {
    /// Parse the json File and returns success or failure
    /// - parameter resourceFile: json file name
    /// - parameter completion : completion handler
    func parseJson(resourceFile: String, completion: @escaping(_ result: ParserResult<[Any]>) -> Void) {
        guard
            let path = Bundle.main.path(forResource: resourceFile, ofType: "json")
            else {
                return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response: [City] = try JSONDecoder().decode([City].self, from: data)
            let sortedResponse = response.sorted { $0.cityName < $1.cityName }
            completion(.success(sortedResponse))
        } catch {
            completion(.error(ErrorConstants.kParsingFailedError))
        }
      
    }
}
