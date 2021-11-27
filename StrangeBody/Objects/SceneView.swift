//
//  SceneView.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 27.11.2021.
//

import ARKit
import SceneKit
import SwiftUI

struct SceneViewContainer: UIViewRepresentable {
  func makeUIView(context: Context) -> ARSCNView {
    let sceneView = SceneView(frame: .zero)
    sceneView.configure()
    return sceneView
  }
  
  func updateUIView(_ uiView: ARSCNView, context: Context) {}
}

class SceneView: ARSCNView {
  func configure() {
    delegate = self
    
    let configuration = ARWorldTrackingConfiguration()
    scene = SCNScene()
    session.run(configuration)
    
    addStasCube()
  }
}

// MARK: - ARSCNViewDelegate
extension SceneView: ARSCNViewDelegate {
  func session(_ session: ARSession, didFailWithError error: Error) {
    // Present an error message to the user
    
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
  }
}

// MARK: - Private methods
private extension SceneView {
  func addStasCube() {
    addNewCubeModel(
      size: 0.2,
      position: SCNVector3(0, 0, -1),
      texture: UIImage(named: "stas"),
      scene: scene
    )
  }
  
  func getCubeNode(size: CGFloat, position: SCNVector3, texture: Any?) -> SCNNode {
    let boxGeometry = SCNBox(
      width: size,
      height: size,
      length: size,
      chamferRadius: 0
    )
    
    let material = SCNMaterial()
    material.diffuse.contents = texture
    
    let boxNode = SCNNode(geometry: boxGeometry)
    boxNode.geometry?.materials = [material]
    boxNode.position = position
    
    return boxNode
  }
  
  func addNewCubeModel(size: CGFloat, position: SCNVector3, texture: Any?, scene: SCNScene) {
    let node = getCubeNode(size: size, position: position, texture: texture)
    scene.rootNode.addChildNode(node)
  }
}
