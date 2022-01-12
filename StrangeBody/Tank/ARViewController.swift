import UIKit
import ARKit
import RealityKit

class ARViewController: UIViewController {
  
  private let arView = ARView()
   
  private var tankAnchor: TinyToyTank._TinyToyTank?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    addARView()
    addTank()
  }
  
  private func addARView() {
    arView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(arView)
    
    NSLayoutConstraint.activate([
      arView.topAnchor.constraint(equalTo: view.topAnchor),
      arView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      arView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      arView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  func addTank() {
    tankAnchor = try! TinyToyTank.load_TinyToyTank()
    arView.scene.anchors.append(tankAnchor!)
  }
}
