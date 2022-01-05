//
//  ContentView.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 27.11.2021.
//

import SwiftUI

struct ContentView : View {
  
  @StateObject private var placementSettings = PlacementSettings()
  
  @State private var showBrowse = false
  
  var body: some View {
    ZStack(alignment: .bottom) {
      SceneViewContainer()
      
      if placementSettings.selectedModel == nil {
        ControlView(showBrowse: $showBrowse)
      } else {
        PlacementView()
      }
    }
    .edgesIgnoringSafeArea(.all)
    .environmentObject(placementSettings)
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
