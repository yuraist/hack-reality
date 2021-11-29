//
//  ControlView.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 29.11.2021.
//

import SwiftUI

struct ControlView: View {
  var body: some View {
    VStack {
      ControlVisibilityToggleButton()
      
      Spacer()
      
      ControlButtonBar()
    }
  }
}

struct ControlView_Previews: PreviewProvider {
  static var previews: some View {
    ControlView()
  }
}


struct ControlVisibilityToggleButton: View {
  var body: some View {
    EmptyView()
  }
}

struct ControlButtonBar: View {
  var body: some View {
    HStack {
      ControlButton(systemIconName: "clock.fill") {
        
      }
      
      Spacer()
      
      ControlButton(systemIconName: "square.grid.2x2") {
        
      }
      
      Spacer()
      
      ControlButton(systemIconName: "slider.horizontal.3") {
        
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
