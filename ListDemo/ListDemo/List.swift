//
//  List.swift
//  ListDemo
//
//  Created by Jitendra Deore on 18/06/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation


class List {
    let title: String
    var listItems: [ListItem] = []
    
    init?(json: JSONItem) {
        guard let rows = json["rows"] as? [JSONItem] else{
            return nil
        }
        self.title = json["title"] as? String ?? ""
        self.listItems = rows.map({ ListItem(with: $0 )}).compactMap( { $0 })
    }
}

