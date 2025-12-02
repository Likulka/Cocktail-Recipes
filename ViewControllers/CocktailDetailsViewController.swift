//
//  CocktailDetailsTableViewTableViewController.swift
//  Coctail Recipes
//
//  Created by Anzhelika on 30.11.25.
//

import UIKit

final class CocktailDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var cocktailImage: UIImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var glass: UILabel!
    @IBOutlet var alcoLabel: UILabel!
    @IBOutlet var preparationInstructions: UILabel!
    
    // MARK: - Private properties
    private var cocktail: CocktailDetail!
    private var ingredients: [Ingredient]!
    
    // MARK: - Public properties
    var cocktailID: String!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCocktail()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CocktailDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktail?.ingredientsPairs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
                
        var content = cell.defaultContentConfiguration()
        
        print(ingredients[indexPath.row])
        content.text = ingredients[indexPath.row].ingredient
        content.secondaryText = ingredients[indexPath.row].measure
        cell.contentConfiguration = content
        
        return cell
    }
    
}
    
extension CocktailDetailsViewController {
    // MARK: URL requests
    private func fetchCocktail() {
        NetworkManager.shared.fetchData(
            CocktailDetailResponse.self,
            from: Link.showCocktail.url, paramName: "i",
            paramValue: cocktailID) { [weak self] result in
                print("START DETAILS")
                switch result {
                case .success(let response):
                    guard let detail = response.drinks.first else { return }
                    self?.cocktail = detail
                    self?.ingredients = detail.ingredientsPairs
                    self?.tableView.reloadData()
                    DispatchQueue.main.async() {
                        self?.title = detail.strDrink
                        self?.alcoLabel.text = detail.strAlcoholic
                        self?.glass.text = detail.strGlass
                        self?.preparationInstructions.text = detail.strInstructions
                        self?.tableView.reloadData()
                    }
                    
                    NetworkManager.shared
                        .loadImage(from: detail.strDrinkThumb, with: { data in
                            guard let data, let image = UIImage(data: data) else { return }
                            
                            DispatchQueue.main.sync {
                                self?.cocktailImage.image = image
                                self?.tableView.reloadData()
                            }
                        })

                case .failure(let error):
                    print(error)
                }
            }
    }
}
