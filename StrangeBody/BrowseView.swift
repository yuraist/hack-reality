//
//  BrowseView.swift
//  StrangeBody
//
//  Created by Yura Istomin on 27.12.2021.
//

import SwiftUI

struct BrowseView: View {
  
  @Binding var showBrowse: Bool
  
  var body: some View {
    NavigationView {
      ScrollView(showsIndicators: false) {
        
      }
      .navigationTitle("Browse")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showBrowse = false
          } label: {
            Text("Done")
          }
        }
      }
    }
  }
}

struct BrowseView_Previews: PreviewProvider {
  static var previews: some View {
    BrowseView(showBrowse: .constant(true))
  }
}
