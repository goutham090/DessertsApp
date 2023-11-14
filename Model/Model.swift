//
//  Model.swift
//  
//
//  
//

import Foundation

struct mealResponse: Codable {
  let meals: [[String: String?]]
}

struct Response: Codable {
  var meals:[Meal]
}

struct Meal: Codable {
  var strMeal: String
  var strMealThumb: String
  var idMeal: String
}


