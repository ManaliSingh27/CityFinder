//
//  ParserViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 29/05/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation

enum ParserResult<T>
{
    case Success(T)
    case Error(String)
}

protocol ParseData {
      func parseJson(resourceFile:String, completion : @escaping(_ result : ParserResult<Array<Any>>) -> Void)
}

class ParserViewModel
{
    var dataParserObj : ParseData
    
    init(dataParser : ParseData) {
        self.dataParserObj = dataParser
    }
    
    func parseJson(resourceFile:String, completion : @escaping(_ result : ParserResult<Array<Any>>) -> Void)
    {
        dataParserObj.parseJson(resourceFile: resourceFile, completion: {(result) in
            completion(result)
        })
    }
}


class CityParserViewModel: ParseData {
    
    func parseJson(resourceFile:String, completion : @escaping(_ result : ParserResult<Array<Any>>) -> Void)
    {
        guard
            let path = Bundle.main.path(forResource: resourceFile, ofType: "json")
            else {
                return
        }
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response = try JSONDecoder().decode([City].self, from: data)
            completion(.Success(response))
           
        }
        catch
        {
            completion(.Error("Parsing Failed"))
        }
      
    }
}
