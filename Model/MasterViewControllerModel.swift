//
//  MasterViewControllerViewModel.swift
//  FetchRewards
//
//  
//

import Foundation

class MasterViewControllerModel  {
  
  var numberOfMeals = 0
  var mealData:[Meal] = [Meal(strMeal: "", strMealThumb: "", idMeal: "")]
  
}

extension MasterViewControllerModel: modelUpdate  {
  func updateModel(data: Data)  {
    let response = try? JSONDecoder().decode(Response.self, from: data)
    guard let response = response else {return}
    numberOfMeals = response.meals.count
    mealData = response.meals
    DispatchQueue.main.async {
      NotificationCenter.default.post(name: .masterModelHasUpdated, object: nil)
    }
  }
}

extension Notification.Name {
  static let masterModelHasUpdated = Notification.Name("masterModelHasUpdated")
}
