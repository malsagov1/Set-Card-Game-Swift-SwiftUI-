//
//  CardView.swift
//  Memorize
//
//  Created by Умар Мальсагов on 13.08.2021.
//

import SwiftUI

struct Cardview: View {
    let card: SetGameViewModel.Card
    let oppacityOfshape: Double = 0.2
    init(card: SetGameViewModel.Card) {
        self.card = card
    }
    

    var body: some View {
                
        GeometryReader(content: { geometry in
            ZStack {
                Group {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill(Color(.white))
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(status(Card: card))
                }.animation(nil, value: status(Card: card))

                    
                    
                HStack {
                    let number_of_shapes = cardCase(arg1: 1, arg2: 2, arg3: 3, StateVariable: card.numberOfShapes)
                    let color_of_shapes = cardCase(arg1: Color.yellow, arg2: Color.purple, arg3: Color.red, StateVariable: card.color)
                    ForEach((1...number_of_shapes), id: \.self)
                    { _ in
                        shaper.aspectRatio(1/3, contentMode: .fit)
                        .padding(5)
                            .font(font(in: geometry.size)).foregroundColor(color_of_shapes)
                    }
                }
                
                
            }.animateStatus(status: card.status)
        })
        }
     
            

    
    
    
    
    var shaper: some View {
        cardCase(arg1: cardCase(arg1: AnyView(Diamond().stroke()), arg2: AnyView(Diamond().fill()), arg3: AnyView(Diamond().opacity(oppacityOfshape)), StateVariable: card.Shading),
                 arg2: cardCase(arg1: AnyView(Rectangle().stroke()), arg2: AnyView(Rectangle().fill()), arg3: AnyView(Rectangle().opacity(oppacityOfshape)), StateVariable: card.Shading),
                 arg3: cardCase(arg1: AnyView(Circle().stroke()), arg2: AnyView(Circle().fill()), arg3: AnyView(Circle().opacity(oppacityOfshape)), StateVariable: card.Shading), StateVariable: card.Shapes)
        
    }
    
        private func font (in size: CGSize) -> Font {
            Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale )
        }
   
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 2
        static let fontScale: CGFloat = 0.7
    }

    private func cardCase<T> (arg1: T, arg2: T, arg3: T, StateVariable: States) -> T {
        switch StateVariable {
        case .State1: return arg1
        case .State2: return arg2
        case .State3: return arg3
        }
    }
    
   private func status(Card: SetGame.Card) -> Color {
    
        if let currentstatus = Card.status {
            return cardCase(arg1: Color.blue, arg2: Color.red, arg3: Color.green, StateVariable: currentstatus)
        }
        else {
            return Color.gray
        }
    }
}
