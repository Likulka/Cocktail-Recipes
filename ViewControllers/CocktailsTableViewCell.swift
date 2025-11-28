//
//  CocktailsTableViewCell.swift
//  Coctail Recipes
//
//  Created by Anzhelika on 25.11.25.
//

import UIKit

class CocktailsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet var cocktailTitle: UILabel!
    @IBOutlet var cocktailCategory: UILabel!
    @IBOutlet var alcoholLabel: UILabel!
    
    @IBOutlet var cocktailImage: UIImageView!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
