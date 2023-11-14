//
//  DetailViewController.swift
//  FetchRewards
//
//  
//

import UIKit

class DetailViewController: UIViewController {
  
  var recipeText: UITextView!
  
  var ingredientsTableView: UITableView!
  
  var mealId: String = ""
  
  var model = DetailViewControllerModel()
  
  
  //Used a fixed-size UITextView so that users are aware ingredients are at the bottom. However, different designs are also possible but I chose this.
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    recipeText = UITextView()
    self.view.addSubview(recipeText)
    recipeText.translatesAutoresizingMaskIntoConstraints = false
    recipeText.font = UIFont.systemFont(ofSize: 17.0)
    
    NSLayoutConstraint.activate([
      recipeText.leadingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leadingAnchor),
      recipeText.trailingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.trailingAnchor),
      recipeText.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor),
      recipeText.heightAnchor.constraint(equalToConstant:350)
    ])
    
    
    
    ingredientsTableView = UITableView()
    self.view.addSubview(ingredientsTableView)
    ingredientsTableView.translatesAutoresizingMaskIntoConstraints = false
    // Do any additional setup after loading the view.
    
    NSLayoutConstraint.activate([
      ingredientsTableView.leadingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leadingAnchor),
      ingredientsTableView.trailingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.trailingAnchor),
      ingredientsTableView.topAnchor.constraint(equalTo:self.recipeText.bottomAnchor, constant: 20),
      ingredientsTableView.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor)
    ])
    self.ingredientsTableView.separatorColor = UIColor.clear
    
    ingredientsTableView.delegate = self
    ingredientsTableView.dataSource = self
    
    
    recipeText.isEditable = false
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.updateViews),
      name: .detailModelHasUpdated,
      object: nil)
    let url = Constants.detailUrl + mealId
    NetworkLayer(delegate: self.model as modelUpdate).call(url: url)
    
    
    
  }
  
  @objc func updateViews() {
    DispatchQueue.main.async{ [weak self] in
      guard let self = self else {return}
      self.ingredientsTableView.reloadData()
      self.recipeText.text = model.recipeText
      self.title = model.title
      
    }
    
    
  }
  
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource
{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    model.nonEmptyIngredients
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell()
    if model.ingredients.count == 0{return UITableViewCell()}
    else { cell.textLabel?.text = model.ingredients[indexPath.row]
      
      return cell}
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView =  UILabel()
    
    headerView.font = UIFont.systemFont(ofSize: 20)
    headerView.text = "Quantities/Ingredients"
    headerView.backgroundColor = .white
    return headerView
  }
}



