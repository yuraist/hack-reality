import SwiftUI
import Combine
import RealityKit

class PlacementSettings: ObservableObject {
  
  @Published var selectedModel: Model? {
    willSet {
      print("Setting selectedModel to \(String(describing: newValue))")
    }
  }
  
  @Published var confirmedModel: Model? {
    willSet {
      guard let newModel = newValue else {
        print("Clearing confirmed model")
        return
      }
      
      print("Settings confirmedModel to \(String(describing: newModel))")
    }
  }
  
  var sceneObserver: Cancellable?
}
