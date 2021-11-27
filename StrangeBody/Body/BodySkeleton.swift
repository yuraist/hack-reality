//
//  BodySkeleton.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 27.11.2021.
//

import ARKit
import RealityKit

class BodySkeleton: Entity {
  var joints: [String: Entity] = [:]
  
  required init(for bodyAnchor: ARBodyAnchor) {
    super.init()
    
    for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
      let jointRadius: Float = 0.03
      let jointColor: UIColor = .green
      
      let jointEntity = makeJoint(radius: jointRadius, color: jointColor)
      joints[jointName] = jointEntity
      self.addChild(jointEntity)
    }
    
    self.update(with: bodyAnchor)
  }
  
  required init() {
    fatalError("init() has not been implemented")
  }
  
  /// Creates a sphere-shaped entity with specified radius and color for a joint
  func makeJoint(radius: Float, color: UIColor) -> Entity {
    let mesh = MeshResource.generateSphere(radius: radius)
    let material = SimpleMaterial(color: color, roughness: 0.8, isMetallic: false)
    let modelEntity = ModelEntity(mesh: mesh, materials: [material])
    return modelEntity
  }
  
  /// Updates the position and orientation of each jointEntity
  func update(with bodyAnchor: ARBodyAnchor) {
    let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
    
    for jointName in ARSkeletonDefinition.defaultBody3D.jointNames {
      guard let jointEntity = joints[jointName],
         let jointTransform = bodyAnchor.skeleton.modelTransform(
          for: ARSkeleton.JointName(rawValue: jointName)
         ) else { continue }
        
      let jointOffset = simd_make_float3(jointTransform.columns.3)
      jointEntity.position = rootPosition + jointOffset
      jointEntity.orientation = Transform(matrix: jointTransform).rotation
    }
  }
}
