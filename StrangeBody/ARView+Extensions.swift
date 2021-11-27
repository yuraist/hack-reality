//
//  ARView+Extensions.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 27.11.2021.
//

import ARKit
import RealityKit

extension ARView: ARSessionDelegate {
  func setupForBodyTracking() {
    let config = ARBodyTrackingConfiguration()
    self.session.run(config)
    self.session.delegate = self
  }
  
  public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
    for anchor in anchors {
      guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
      
      if let skeleton = bodySkeleton {
        // bodySkeleton already exists, update pose of all joints
        skeleton.update(with: bodyAnchor)
      } else {
        // Seeinng body for the first time, create bodySkeleton
        let skeleton = BodySkeleton(for: bodyAnchor)
        bodySkeleton = skeleton
        bodySkeletonAnchor.addChild(skeleton)
      }
//        print("Update bodyAnchor \(bodyAnchor)")
//
//        let skeleton = bodyAnchor.skeleton
//        let rootJointTransform = skeleton.modelTransform(for: .root)!
//        let rootJointPosition = simd_make_float3(rootJointTransform.columns.3)
//        print("root: \(rootJointPosition)")
//
//        let leftHandTransform = skeleton.modelTransform(for: .leftHand)!
//        let leftHandOffset = simd_make_float3(leftHandTransform.columns.3)
//        let leftHandPosition = rootJointPosition + leftHandOffset
//        print("leftHand: \(leftHandPosition)")
    }
  }
}
