//
//  CocktailsTableViewController.swift
//  Coctail Recipes
//
//  Created by Anzhelika on 25.11.25.
//

import UIKit

final class CocktailsTableViewController: UITableViewController {
    
    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    private var alcoCocktails: [Cocktail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        fetchAlcoCocktails()
    }
    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alcoCocktails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "CocktailCell",
            for: indexPath
        )
        
        var content = cell.defaultContentConfiguration()
        
        let cocktail = alcoCocktails[indexPath.row]
        
        content.text = cocktail.strDrink
//        content.imageProperties.cornerRadius = 10
        cell.contentConfiguration = content
        
        networkManager
            .loadImage(from: URL(string: cocktail.strDrinkThumb)!) { data in
                guard let data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    var updated = cell.defaultContentConfiguration()
                    updated.text = cocktail.strDrink
                    updated.image = image
                    cell.contentConfiguration = updated

                }
        }
        
        
        return cell
    }
}

// MARK: - URL Requests
extension CocktailsTableViewController {
    private func fetchAlcoCocktails() {
        networkManager
            .fetchData(
                Drinks.self,
                from: Link.showAlcoCocktails.url) { [weak self] result in
                    switch result {
                    case .success(let cocktails):
                        self?.alcoCocktails = cocktails.drinks
                        self?.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    
    
}
