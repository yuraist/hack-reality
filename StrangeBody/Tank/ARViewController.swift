import UIKit
import ARKit
import RealityKit

class ARViewController: UIViewController {
  
  private let arView = ARView()
   
  private var tankAnchor: TinyToyTank._TinyToyTank?
  
  private let tankRightButton = UIButton()
  private let tankLeftButton = UIButton()
  private let tankForwardButton = UIButton()
  private let turretRightButton = UIButton()
  private let turretLeftButton = UIButton()
  private let fireButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    addARView()
    addTank()
    addButtons()
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
  
  private func addTank() {
    tankAnchor = try! TinyToyTank.load_TinyToyTank()
    arView.scene.anchors.append(tankAnchor!)
  }
  
  private func addButtons() {
    let firstStackView = UIStackView(arrangedSubviews: [tankLeftButton, tankForwardButton, tankRightButton])
    firstStackView.axis = .horizontal
    
    let secondStackView = UIStackView(arrangedSubviews: [turretLeftButton, fireButton, turretRightButton])
    secondStackView.axis = .horizontal
    
    tankRightButton.setImage(UIImage(named: "TankRight"), for: .normal)
    tankLeftButton.setImage(UIImage(named: "TankLeft"), for: .normal)
    tankForwardButton.setImage(UIImage(named: "TankForward"), for: .normal)
    turretRightButton.setImage(UIImage(named: "TurretRight"), for: .normal)
    turretLeftButton.setImage(UIImage(named: "TurretLeft"), for: .normal)
    fireButton.setImage(UIImage(named: "CannonFire"), for: .normal)
    
    let thirdStackView = UIStackView(arrangedSubviews: [firstStackView, secondStackView])
    thirdStackView.axis = .vertical
    
    view.addSubview(thirdStackView)
    thirdStackView.translatesAutoresizingMaskIntoConstraints = false
    
    thirdStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    thirdStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
    
    tankRightButton.addAction(UIAction(handler: { _ in
      self.tankAnchor?.notifications.tankRight.post()
    }), for: .touchUpInside)
    
    tankLeftButton.addAction(UIAction(handler: { _ in
      self.tankAnchor?.notifications.tankLeft.post()
    }), for: .touchUpInside)
    
    tankForwardButton.addAction(UIAction(handler: { _ in
      self.tankAnchor?.notifications.tankForward.post()
    }), for: .touchUpInside)
    
    turretRightButton.addAction(UIAction(handler: { _ in
      self.tankAnchor?.notifications.turretRight.post()
    }), for: .touchUpInside)
    
    turretLeftButton.addAction(UIAction(handler: { _ in
      self.tankAnchor?.notifications.turretLeft.post()
    }), for: .touchUpInside)
    
    fireButton.addAction(UIAction(handler: { _ in
      self.tankAnchor?.notifications.cannonFire.post()
    }), for: .touchUpInside)
  }
}
