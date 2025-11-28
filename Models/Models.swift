//
//  Models.swift
//  Coctail Recipes
//
//  Created by Anzhelika on 21.11.25.
//

import Foundation

struct Cocktail: Decodable, Sendable {
    let strDrink: String
    let strDrinkThumb: String
}

struct CoctailDetail: Decodable {
    let strDrink: String
    let strAlcoholic: String
    let strGlass: String
    let strInstructions: String
    let strDrinkThumb: String
}

struct Drinks: Decodable {
    let drinks: [Cocktail]
}

enum Link: Sendable {
    case showAlcoCocktails
    case showOrdinaryCocktails
    case showCocktail
    
    var url: URL {
        switch self {
        case .showAlcoCocktails:
            return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic")!
        case .showOrdinaryCocktails:
            return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic")!
        case .showCocktail:
            return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita")!
        }
    }
}


