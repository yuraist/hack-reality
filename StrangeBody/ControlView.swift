//
//  ControlView.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 29.11.2021.
//

import SwiftUI

struct ControlView: View {
  
  @Binding var showBrowse: Bool
  @Binding var showSettings: Bool
  @State private var isControlsVisible = true
  
  var body: some View {
    VStack {
      ControlVisibilityToggleButton(isControlsVisible: $isControlsVisible)
      
      Spacer()
      
      if isControlsVisible {
        ControlButtonBar(showBrowse: $showBrowse, showSettings: $showSettings)
      }
    }
  }
}

struct ControlView_Previews: PreviewProvider {
  static var previews: some View {
    ControlView(showBrowse: .constant(false), showSettings: .constant(false))
  }
}


struct ControlVisibilityToggleButton: View {
  
  @Binding var isControlsVisible: Bool
  
  var body: some View {
    HStack {
      Spacer()
      
      ZStack {
        Color.black.opacity(0.25)
        
        Button {
          isControlsVisible.toggle()
        } label: {
          Image(systemName: "rectangle")
            .font(.system(size: 25))
            .foregroundColor(.white)
            .buttonStyle(.plain)
        }
      }
      .frame(width: 50, height: 50)
      .cornerRadius(8)
    }
    .padding(.top, 45)
    .padding(.trailing, 25)
  }
}

struct ControlButtonBar: View {
  
  @Binding var showBrowse: Bool
  @Binding var showSettings: Bool
  
  var body: some View {
    HStack {
      ControlButton(systemIconName: "clock.fill") {}
      
      Spacer()
      
      ControlButton(systemIconName: "square.grid.2x2") {
        showBrowse = true
      }.sheet(isPresented: $showBrowse) {
        BrowseView(showBrowse: $showBrowse)
      }
      
      Spacer()
      
      ControlButton(systemIconName: "slider.horizontal.3") {
        showSettings = true
      }
      .sheet(isPresented: $showSettings) {
        SettingsView(showSettings: $showSettings)
      }
    }
    .frame(maxWidth: 500)
    .padding(30)
    .background(Color.black.opacity(0.25))
  }
}

struct ControlButton: View {
  
  let systemIconName: String
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      Image(systemName: systemIconName)
        .font(.system(size: 35))
        .foregroundColor(.white)
        .buttonStyle(.plain)
    }
  }
}
