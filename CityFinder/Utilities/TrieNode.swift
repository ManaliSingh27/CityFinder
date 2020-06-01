//
//  TrieNode.swift
//  CityFinder
//
//  Created by Manali Mogre on 01/06/2020.
//  Copyright © 2020 Manali Mogre. All rights reserved.
//

public class TrieNode {
    
    var key: String?
    var children: [TrieNode]
    var isFinal: Bool
    var level: Int
    var cityModel: CityViewModel?
    
    init() {
        self.children = [TrieNode]()
        self.isFinal = false
        self.level = 0
    }
}

class Trie {
    private var root = TrieNode()
    
    //builds a tree hierarchy of dictionary content
    func append(word keyword: String, viewModel: CityViewModel) {
        //trivial case
        guard !keyword.isEmpty  else {
            return
        }
        
        var current: TrieNode = root
        while keyword.count != current.level {
            
            var childToUse: TrieNode!
            let searchKey = keyword.substring(toIndex: current.level + 1)
            
            //iterate through child nodes
            for child in current.children {
                if child.key?.lowercased() == searchKey {
                    childToUse = child
                    break
                }
            }
            
            //new node
            if childToUse == nil {
                childToUse = TrieNode()
                childToUse.key = searchKey
                childToUse.level = current.level + 1
                current.children.append(childToUse)
            }
            current = childToUse
            
        } //end while
        
        //final end of word check
        if keyword.count == current.level {
            current.isFinal = true
            current.cityModel = viewModel
            return
        }
        
    } //end function
    
    //find words based on the prefix
    func find(_ keyword: String) -> [CityViewModel]? {
        
        //trivial case
        guard keyword.length > 0 else {
            return nil
        }
        
        var current: TrieNode = root
        var wordList = [CityViewModel]()
        
        while keyword.length != current.level {
            
            var childToUse: TrieNode!
            let searchKey = keyword.substring(toIndex: current.level + 1)
            
            //iterate through any child nodes
            for child in current.children {
                
                if child.key?.lowercased() == searchKey {
                    childToUse = child
                    current = childToUse
                    break
                }
            }
            
            if childToUse == nil {
                return nil
            }
            
        } //end while
        
        //retrieve the keyword and any descendants
        if (current.key?.lowercased() == keyword.lowercased()) && (current.isFinal) {
            wordList.append(current.cityModel!)
        }
        
        //manali -- chcek till last char is matched -- no children left
        var tempChildArray = [TrieNode]()
        for child in current.children{
            tempChildArray.append(child)
        }
        
        while !tempChildArray.isEmpty {
            //include only children that are words
            for child in current.children {
                if child.isFinal == true {
                    wordList.append(child.cityModel!)
                }
                if !child.children.isEmpty {
                    for child1 in child.children{
                        tempChildArray.append(child1)
                    }
                }
            }
            current = tempChildArray.first!
            tempChildArray.removeFirst()
        }
        return wordList
    } //end function
}

extension String {
    
    //compute the length
    var length: Int {
        return self.count
    }
    
    //returns characters up to a specified integer
    func substring(toIndex: Int) -> String {
        
        //define the range
        let range = self.index(self.startIndex, offsetBy: toIndex)
        return String(self[..<range]).lowercased()
    }
}
