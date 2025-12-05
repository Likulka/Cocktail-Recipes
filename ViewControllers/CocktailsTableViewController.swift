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
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 140
        fetchAlcoCocktails()
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails",
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let detailVC = segue.destination as? CocktailDetailsViewController {
            let cocktail = alcoCocktails[indexPath.row]
            detailVC.cocktailID = cocktail.idDrink
        }
    }
}

extension CocktailsTableViewController {
    
    // MARK: - TableViewProtocol
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
        ) as! CocktailsTableViewCell
        
//        var content = cell.defaultContentConfiguration()
//
        let cocktail = alcoCocktails[indexPath.row]
//        content.text = cocktail.strDrink
//        cell.contentConfiguration = content

        cell.configure(with: cocktail)

//        networkManager
//            .loadImage(from: cocktail.strDrinkThumb) { data in
//                guard let data, let image = UIImage(data: data) else { return }
//                DispatchQueue.main.async {
//                    var updated = cell.defaultContentConfiguration()
//                    updated.text = cocktail.strDrink
//                    updated.textProperties.font = UIFont(name: "AvenirNext-DemiBold", size: 22)!
//                    updated.image = image
//                    updated.imageProperties.cornerRadius = 10
//                    cell.contentConfiguration = updated
//                }
//        }
        
        return cell
    }
    
    // MARK: - URL Requests
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
