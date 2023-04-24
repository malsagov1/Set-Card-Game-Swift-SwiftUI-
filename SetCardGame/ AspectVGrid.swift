//
//   AspectVGrid.swift
//  Memorize
//
//  Created by Умар Мальсагов on 14.11.2021.
//

import SwiftUI

struct AspectVGrid<item, ItemView>: View where ItemView: View, item: Identifiable {
    var items: [item]
    var aspectRatio: CGFloat
    var content: (item) -> ItemView
    
    init (items: [item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    var numberOfItems: Int {
        if items.count < 48 {
            return items.count
        }
        else {
            return 48
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                    let width: CGFloat = widthThatFits(itemCount: numberOfItems, in: geometry.size, itemAspectRatio: aspectRatio)
           LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0)  {
                      ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
//                            .animation(.easeInOut(duration: 0.5))
                    }
                    
            }
                
            }.background(Color(.clear))
     
        }
}
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
        
    }


private func widthThatFits (itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
      var columnCount = 1
    var rowCount = itemCount
    repeat {
        let itemwidth = size.width / CGFloat(columnCount)
        let itemHeight = itemwidth / itemAspectRatio
        if CGFloat (rowCount) * itemHeight < size.height {
            break }
        columnCount += 1
        rowCount = (itemCount + (columnCount - 1)) / columnCount
        
    } while columnCount < itemCount
    if columnCount > itemCount {
            columnCount = itemCount
    }
            return floor (size.width / CGFloat(columnCount))
}
    
}
