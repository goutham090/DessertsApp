//
//  NetworkLayer.swift
//  FetchRewards
//
//  
//

import Foundation

class NetworkLayer {
  
  weak var delegate:modelUpdate?
  
  init(delegate:modelUpdate) {
    self.delegate = delegate
  }
  
  func call(url: String) {
    let url = URL(string:url)!
    let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
      guard let data = data, let delegate = self.delegate else { return }
      
      delegate.updateModel(data: data)
    }
    task.resume()
    
  }
  
}

protocol modelUpdate: class  {
  func updateModel(data: Data)
}
