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
        ModelsByCategoryGrid(isShowing: $showBrowse)
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
  
  var title: String
  var items: [Model]
  
  @Binding var isShowing: Bool
  
  private let gridLayout = [GridItem(.fixed(150))]
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.title2).bold()
        .padding(.horizontal, 22)
        .padding(.vertical, 10)
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: gridLayout, spacing: 30) {
          ForEach(0..<items.count) { item in
            BrowseItem(image: items[item].thumbnail) {
              self.isShowing = false
            }
          }
        }
        .padding(.leading, 22)
        .padding(.vertical, 10)
      }
    }
  }
}

struct BrowseItem: View {
  
  let image: UIImage
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Image(uiImage: image)
        .resizable()
        .scaledToFit()
        .background(Color(UIColor.secondarySystemFill))
        .frame(width: 150, height: 150)
        .cornerRadius(10)
    }
  }
}

struct ModelsByCategoryGrid: View {
  
  let models = Models()
  @Binding var isShowing: Bool
  
  var body: some View {
    VStack {
      ForEach(ModelCategory.allCases, id: \.self) { category in
        if let modelsByCategory = models.get(category: category) {
          HorizontalGrid(title: category.label, items: modelsByCategory, isShowing: $isShowing)
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
