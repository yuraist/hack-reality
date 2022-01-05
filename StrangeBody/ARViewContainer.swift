import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
  
  @EnvironmentObject var placementSettings: PlacementSettings
  @EnvironmentObject var sessionSettings: SessionSettings
  
  func makeUIView(context: Context) -> CustomARView {
    let arView = CustomARView(frame: .zero, sessionSettings: sessionSettings)
    placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
      self.updateScene(for: arView)
    }
    return arView
  }
  
  func updateUIView(_ uiView: CustomARView, context: Context) {}
  
  private func updateScene(for arView: CustomARView) {
    arView.focusEntity?.isEnabled = placementSettings.selectedModel != nil
    
    if let confirmedModel = placementSettings.confirmedModel, let modelEntity = confirmedModel.modelEntity {
      placementSettings.confirmedModel = nil
      place(modelEntity, in: arView)
    }
  }
  
  private func place(_ modelEntity: ModelEntity, in arView: ARView) {
    let clonedEntity = modelEntity.clone(recursive: true)
    clonedEntity.generateCollisionShapes(recursive: true)
    arView.installGestures([.translation, .rotation], for: clonedEntity)
    
    let anchorEntity = AnchorEntity(plane: .any)
    anchorEntity.addChild(clonedEntity)
    
    arView.scene.addAnchor(anchorEntity)
    
    print("Added model entity onto the scene")
  }
}
