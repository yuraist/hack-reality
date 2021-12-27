//
//  Model.swift
//  StrangeBody
//
//  Created by Yura Istomin on 27.12.2021.
//

import SwiftUI
import RealityKit

enum ModelCategory: CaseIterable {
  case table
  case decor
  case chair
  case light
  
  var label: String {
    switch self {
    case .table:
      return "Table"
    case .decor:
      return "Decor"
    case .chair:
      return "Chair"
    case .light:
      return "Light"
    }
  }
}

class Model {
  var name: String
  var category: ModelCategory
  var thumbnail: UIImage
  var modelEntity: ModelEntity?
  var scaleCompensation: Float
  
  init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
    self.name = name
    self.category = category
    self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
    self.scaleCompensation = scaleCompensation
  }
}

struct Models {
  var all: [Model] = []
  
  init() {
    all = [Model(name: "Bulka", category: .table)]
  }
  
  func get(category: ModelCategory) -> [Model] {
    all.filter { $0.category == category }
  }
}
