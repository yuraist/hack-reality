//
//  Plane.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 27.11.2021.
//

import ARKit

class Plane: SCNNode {
  var anchor: ARPlaneAnchor
  var planeGeometry: SCNPlane!
  
  init(anchor: ARPlaneAnchor) {
    self.anchor = anchor
    super.init()
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(anchor: ARPlaneAnchor) {
    planeGeometry.width = CGFloat(anchor.extent.x)
    planeGeometry.height = CGFloat(anchor.extent.z)
    
    position = SCNVector3(anchor.center.x, 0, anchor.center.z)
  }
}

private extension Plane {
  func configure() {
    opacity = 0.4
    
    planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
    
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.blue
    
    planeGeometry.materials = [material]
    
    geometry = planeGeometry
    position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    
    transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2), 1, 0, 0)
  }
}
