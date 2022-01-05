import SwiftUI

struct ARViewContainer: UIViewRepresentable {
  func makeUIView(context: Context) -> CustomARView {
    CustomARView(frame: .zero)
  }
  
  func updateUIView(_ uiView: CustomARView, context: Context) {}
}
