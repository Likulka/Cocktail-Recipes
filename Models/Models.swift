//
//  Models.swift
//  Coctail Recipes
//
//  Created by Anzhelika on 21.11.25.
//

nonisolated struct Coctail: Decodable {
    let strDrink: String
    let strAlcoholic: String
    let strGlass: String
    let strInstructions: String
    let strDrinkThumb: String
}

nonisolated struct Drinks: Decodable {
    let drinks: [Coctail]
}
