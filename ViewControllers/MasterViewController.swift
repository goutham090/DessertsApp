//
//  ViewController.swift
//  FetchRewards
//
//
//

import UIKit
import SDWebImage

class TableViewController: UIViewController {
  
  var tableViewMain = UITableView()
  
  var model = MasterViewControllerModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.title = "Desserts"
    self.view.backgroundColor = .white
    
    tableViewMain.delegate = self
    tableViewMain.dataSource = self
    self.view.addSubview(tableViewMain)
    
    tableViewMain.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableViewMain.leadingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.leadingAnchor),
      tableViewMain.trailingAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.trailingAnchor),
      tableViewMain.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor),
      tableViewMain.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.reloadTableView),
      name: .masterModelHasUpdated,
      object: nil)
    NetworkLayer(delegate: self.model as modelUpdate).call(url: Constants.masterUrl)
    
  }
  
  @objc func reloadTableView() {
    tableViewMain.reloadData()
    
  }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return model.numberOfMeals
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = UITableViewCell()
    cell.textLabel?.text = model.mealData[indexPath.row].strMeal
    cell.textLabel?.font.withSize(10)
    
    let url = model.mealData[indexPath.row].strMealThumb
    cell.imageView?.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "imagename"))
    //caching images using SDWebImage
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //create detail vc
    //push from nav conrtroller
    
    let detailVC = DetailViewController()
    detailVC.mealId =  model.mealData[indexPath.row].idMeal
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  
  
  
  
}
