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
        HorizontalGrid()
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

struct HorizontalGrid: View {
  
  private let gridLayout = [GridItem(.fixed(150))]
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Category Title")
        .font(.title2).bold()
        .padding(.horizontal, 22)
        .padding(.vertical, 10)
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: gridLayout, spacing: 30) {
          ForEach(0..<5) { index in
            Color(UIColor.secondarySystemFill)
              .frame(width: 150, height: 150)
              .cornerRadius(10)
          }
        }
        .padding(.leading, 22)
        .padding(.vertical, 10)
      }
    }
  }
}

struct BrowseView_Previews: PreviewProvider {
  static var previews: some View {
    BrowseView(showBrowse: .constant(true))
  }
}
