//
//  Model.swift
//  StrangeBody
//
//  Created by Yura Istomin on 27.12.2021.
//

import Combine
import SwiftUI
import RealityKit

enum ModelCategory: CaseIterable {
  case storage
  case toy
  case chair
  case flower
  
  var label: String {
    switch self {
    case .storage:
      return "Storage"
    case .toy:
      return "Toy"
    case .chair:
      return "Chair"
    case .flower:
      return "Flower"
    }
  }
}

class Model {
  var name: String
  var category: ModelCategory
  var thumbnail: UIImage
  var modelEntity: Entity?
  var scaleCompensation: Float
  
  private var cancellable: AnyCancellable?
  
  init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
    self.name = name
    self.category = category
    self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
    self.scaleCompensation = scaleCompensation
  }
  
  func loadModelEntityAsync() {
    cancellable = Entity.loadAsync(named: name)
      .sink { completion in
        switch completion {
        case .failure(let error):
          print("Model \(self.name) is failed to load: \(error)")
        case .finished:
          break
        }
      } receiveValue: { entity in
        print("Model \(self.name) is successfully loaded: \(entity)")
        self.modelEntity = entity
        self.modelEntity?.scale *= self.scaleCompensation
      }
  }
}

struct Models {
  var all: [Model] = []
  
  init() {
    all = [
      Model(name: "Airplane", category: .toy),
      Model(name: "BucketsShelf", category: .storage),
      Model(name: "Cactus", category: .flower),
      Model(name: "DefaultChair", category: .chair),
      Model(name: "Flower", category: .flower),
      Model(name: "LeatherSofa", category: .chair),
      Model(name: "RedWhiteChair", category: .chair),
      Model(name: "Robot", category: .toy),
      Model(name: "Trash", category: .storage)
    ]
  }
  
  func get(category: ModelCategory) -> [Model] {
    all.filter { $0.category == category }
  }
}
