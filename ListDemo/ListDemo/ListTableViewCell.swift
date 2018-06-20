//
//  ListTableViewCell.swift
//  ListDemo
//
//  Created by Jitendra Deore on 20/06/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import UIKit
import SDWebImage

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    /// Method to display data in the cell
    ///
    /// - Parameter listItem: ListItem object.
    func displayData(with listItem: ListItem) {
        self.titleLabel.text = listItem.title
        self.descriptionLabel.text = listItem.description
        if let imageURL = listItem.imageURL{
            thumbnailImageView?.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "placeHolderImage"))
        }
    }
}
