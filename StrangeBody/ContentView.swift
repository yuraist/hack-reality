//
//  ContentView.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 27.11.2021.
//

import SwiftUI

struct ContentView : View {
  
  @StateObject private var placementSettings = PlacementSettings()
  @StateObject private var sessionSettings = SessionSettings()
  
  @State private var showBrowse = false
  @State private var showSettings = false
  
  var body: some View {
    QuickLookContainer()
//    ZStack(alignment: .bottom) {
////      ARViewContainer()
////      ARTankViewContainer()
//
//      if placementSettings.selectedModel == nil {
//        ControlView(showBrowse: $showBrowse, showSettings: $showSettings )
//      } else {
//        PlacementView()
//      }
//    }
//    .edgesIgnoringSafeArea(.all)
//    .environmentObject(placementSettings)
//    .environmentObject(sessionSettings)
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
