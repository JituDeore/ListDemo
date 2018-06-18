//
//  ListItem.swift
//  ListDemo
//
//  Created by Jitendra Deore on 18/06/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation

class ListItem {
    
    let title: String!
    let description: String?
    let imageURL: String?
    
    init?(with dictionaryData: JSONItem) {
        guard let title = dictionaryData["title"] as? String else{
                return nil
        }
        self.title = title
        self.description = dictionaryData["description"] as? String ?? ""
        self.imageURL = dictionaryData["imageHref"] as? String ?? ""
    }
}


