//
//  ContentView.swift
//  StrangeBody
//
//  Created by Юрий Истомин on 27.11.2021.
//

import SwiftUI

struct ContentView : View {
  var body: some View {
    return ARBodyViewContainer().edgesIgnoringSafeArea(.all)
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
