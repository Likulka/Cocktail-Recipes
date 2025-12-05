//
//  CocktailsTableViewCell.swift
//  Coctail Recipes
//
//  Created by Anzhelika on 25.11.25.
//

import UIKit

final class CocktailsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet var cocktailTitle: UILabel!
    @IBOutlet var cocktailImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func prepareForReuse() {
        super.prepareForReuse()
        cocktailImage.image = nil
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with cocktail: Cocktail) {
        cocktailTitle.text = cocktail.strDrink
        
        NetworkManager.shared.loadImage(from: cocktail.strDrinkThumb) { [weak self] data in
            guard let data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() {
                self?.cocktailImage.image = image
                self?.activityIndicator.stopAnimating()
            }
            
        }
    }
    

}
