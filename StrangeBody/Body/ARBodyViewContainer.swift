//
//  ARBodyViewContainer.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 27.11.2021.
//

import SwiftUI
import RealityKit

var bodySkeleton: BodySkeleton?
var bodySkeletonAnchor = AnchorEntity()

struct ARBodyViewContainer: UIViewRepresentable {
  
  func makeUIView(context: Context) -> ARView {
    
    let arView = ARBodyView(frame: .zero)
    arView.setupForBodyTracking()
    arView.scene.addAnchor(bodySkeletonAnchor)
    
    return arView
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {}
  
}
