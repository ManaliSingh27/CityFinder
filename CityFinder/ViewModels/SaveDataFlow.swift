//
//  SaveDataFlow.swift
//  CityFinder
//
//  Created by Manali Mogre on 03/06/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

import Foundation
protocol SaveData {
    func saveCitiesDataInTrieFormat(cities: [City], trieNode: CityNodeViewModel, completion: @escaping() -> Void)
}

class SaveDataFlow {
    var saveDataObj: SaveData
    init(saveDataFlow: SaveData) {
        self.saveDataObj = saveDataFlow
    }
    func saveCitiesDataInTrieFormat(cities: [City], trieNode: CityNodeViewModel, completion: @escaping() -> Void) {
        self.saveDataObj.saveCitiesDataInTrieFormat(cities: cities, trieNode: trieNode, completion: {
            completion()
        })
    }
}

final class SaveDataFlowInTrie: SaveData {
    /// Creates a Trie with Cities data
    /// - parameter cities: array of cities to be saved in Trie
    /// - parameter trieNode: Trie Root Node created
    /// - parameter completion : completion handler
    func saveCitiesDataInTrieFormat(cities: [City], trieNode: CityNodeViewModel, completion: @escaping() -> Void) {
        var cityCount: Int = 0
        for city in cities {
            trieNode.append(viewModel: CityViewModel(city: city))
            cityCount += 1
            if cityCount == cities.count {
                // Show the cities list on view after all the cities are saved in City Trie to enable fast search
                completion()
            }
        }
    }   
}
