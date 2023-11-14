//
//  DetailViewControllerViewModel.swift
//  FetchRewards
//
//  
//

import Foundation

class DetailViewControllerModel {
  
  
  var ingredients:[String] = []
  
  var nonEmptyIngredients = 0
  
  var mealId = ""
  
  var recipeText = ""
  
  var title = ""
  
}

extension DetailViewControllerModel: modelUpdate
{
  func updateModel(data: Data)  {
    let response = try? JSONDecoder().decode(mealResponse.self, from: data)
    guard let response = response else {return}
    let ingredients = response.meals[0]
    DispatchQueue.main.async {
      
      guard let mealNameOptional = ingredients["strMeal"], let mealNameUnwrapped = mealNameOptional else {return}
        self.title = mealNameUnwrapped + " Recipe"
      
      guard let strInstructionsOptional = ingredients["strInstructions"], let strInstructionsUnwrapped = strInstructionsOptional else {return}
      self.recipeText = strInstructionsUnwrapped
      
      for i in 1...20 {
        
        guard let measure = ingredients["strMeasure" + String(i)], let ingredient = ingredients["strIngredient" +  String(i)] else
        {return
        }
        
        
        self.ingredients.append((measure ?? "") + " " + (ingredient ?? ""))
        //Deal with empty values
        if (measure != "" ) && (ingredient != "") {
          self.nonEmptyIngredients = self.nonEmptyIngredients + 1
        }
      }
      DispatchQueue.main.async {
        NotificationCenter.default.post(name: .detailModelHasUpdated, object: nil)
      }
    }
    
  }
}

extension Notification.Name {
  static let detailModelHasUpdated = Notification.Name("detailModelHasUpdated")
}
