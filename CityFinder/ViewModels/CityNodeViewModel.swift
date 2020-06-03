//
//  CityNodeViewModel.swift
//  CityFinder
//
//  Created by Manali Mogre on 02/06/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

class CityNodeViewModel {
    private var root = CityNode()
    
    /// Builds a tree hierarchy of cities based on view model passed as input
    /// - parameter viewModel: City View Model having all City information
    func append(viewModel: CityViewModel) {
        let word = viewModel.cityTitle
        guard !word.isEmpty  else {
            return
        }
        var currentNode: CityNode = root
        while word.count != currentNode.level {
            var childToUse: CityNode!
            let searchKey = word.substring(toIndex: currentNode.level + 1)
            //iterate through child nodes
            for child in currentNode.children {
                if child.key?.lowercased() == searchKey {
                    childToUse = child
                    break
                }
            }
            //new node
            if childToUse == nil {
                childToUse = CityNode()
                childToUse.key = searchKey
                childToUse.level = currentNode.level + 1
                currentNode.children.append(childToUse)
            }
            currentNode = childToUse
        } //end while
        //final end of word check
        if word.count == currentNode.level {
            currentNode.isFinal = true
            var arr: [CityViewModel]? = currentNode.cityModels ?? [CityViewModel]()
            arr?.append(viewModel)
            currentNode.cityModels = arr
            return
        }
    } //end function
    
    /// Finds the cities matching the prefix enterd as keyword
    /// - parameter keyword: Text to be searched in cities
    /// - returns: Array of CityViewModel with city name having keyword as prefix 
    //find words based on the prefix
    func find(keyword: String) -> [CityViewModel]? {
        guard keyword.length > 0 else {
            return nil
        }
        var currentNode: CityNode = root
        var searchedViewModelList = [CityViewModel]()
        while keyword.length != currentNode.level {
            var childToUse: CityNode!
            let searchKey = keyword.substring(toIndex: currentNode.level + 1)
            //iterate through any child nodes
            for child in currentNode.children {
                if child.key?.lowercased() == searchKey {
                    childToUse = child
                    currentNode = childToUse
                    break
                }
            }
            if childToUse == nil {
                return nil
            }
        } //end while
        //retrieve the keyword and any descendants
        if (currentNode.key?.lowercased() == keyword.lowercased()) && (currentNode.isFinal) {
            for cityModel in currentNode.cityModels! {
                searchedViewModelList.append(cityModel)
            }
        }
        var tempChildArray = [CityNode]()
        for child in currentNode.children {
            tempChildArray.append(child)
        }
        while !tempChildArray.isEmpty {
            //include only children that are words
            for child in currentNode.children {
                if child.isFinal == true {
                    for cityModel in child.cityModels! {
                        searchedViewModelList.append(cityModel)
                    }
                }
                if !child.children.isEmpty {
                    for child1 in child.children {
                        tempChildArray.append(child1)
                    }
                }
            }
            currentNode = tempChildArray.first!
            tempChildArray.removeFirst()
        }
        return searchedViewModelList
    } //end function
}
