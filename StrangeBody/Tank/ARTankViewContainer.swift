import ARKit
import SwiftUI
import RealityKit

//struct ARTankViewContainer: UIViewRepresentable {
//
//  func makeUIView(context: Context) -> ARView {
//    let arView = ARView()
//    let tankAnchor = try! TinyToyTank.load_TinyToyTank()
//    arView.scene.anchors.append(tankAnchor)
//
//    return arView
//  }
//
//  func updateUIView(_ uiView: ARView, context: Context) {}
//}

struct ARTankViewContainer: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> ARViewController {
    return ARViewController()
  }
  
  func updateUIViewController(_ uiViewController: ARViewController, context: Context) {}
}
