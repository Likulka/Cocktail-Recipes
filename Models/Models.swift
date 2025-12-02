//
//  Models.swift
//  Coctail Recipes
//
//  Created by Anzhelika on 21.11.25.
//

import Foundation

struct Cocktail: Decodable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
}

struct CocktailDetail: Decodable  {
    let strDrink: String
    let strAlcoholic: String
    let strGlass: String
    let strInstructions: String
    let strDrinkThumb: String
    
    // MARK: - ingredients
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    
    // MARK: - measures
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
}

extension CocktailDetail {
    // MARK: - computed properties
    var ingredients: [String] {
        [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4,
            strIngredient5, strIngredient6, strIngredient7, strIngredient8,
            strIngredient9, strIngredient10, strIngredient11, strIngredient12,
            strIngredient13, strIngredient14, strIngredient15
        ]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
    }
    
    var measures: [String] {
        [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4,
            strMeasure5, strMeasure6, strMeasure7, strMeasure8,
            strMeasure9, strMeasure10, strMeasure11, strMeasure12,
            strMeasure13, strMeasure14, strMeasure15
        ]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
    }
    
    var ingredientsPairs: [Ingredient] {
        var result: [Ingredient] = []
        
        let ingredients = self.ingredients
        let measures = self.measures
        
        for i in 0..<ingredients.count {
                let ing = ingredients[i]       
                let measure = i < measures.count ? measures[i] : ""
                result.append(Ingredient(ingredient: ing, measure: measure))
        }
        return result
    }
}

struct Ingredient {
    let ingredient: String
    let measure: String
}

struct Drinks: Decodable {
    let drinks: [Cocktail]
}

struct CocktailDetailResponse: Decodable {
    let drinks: [CocktailDetail]
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
            return URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php")!
        }
    }
}


