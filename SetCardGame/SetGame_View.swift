//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Умар Мальсагов on 13.08.2021.
//

import SwiftUI

struct SetGame_View: View {
    @ObservedObject var game: SetGameViewModel
    @Namespace private var dealingNamespace
    
    var body: some View {
        
        ZStack {
            VStack {
                    Spacer().frame(height: 130)
                AspectVGrid(items: game.cards, aspectRatio: 3/2) { card in
               
                        Cardview(card: card)
                            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                            .zIndex(zIndex(of: card, array: game.cards))
                            .padding(4)
                            .onTapGesture {
                                game.choose(card)
                            }
                }
                Spacer().frame(height: 75)
            }
                VStack {
                    cardpile
                    Spacer()
                    deck
                }

                    
                
            }
        .padding(.horizontal)
    }
    
    
    
    var NewGame: some View {
        Text("New Game").onTapGesture {
            game.createNewgame()
        }
    }
    var cardpile: some View {
        ZStack {
            ForEach(game.cardpile) { card in
                Cardview(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .animation(.easeInOut(duration: 0.5))
                    .offset(x: CGFloat(card.id))
            }
        }
            .frame(width: 75 * 3/2, height: 75 )
    }

    private func placecards (of card: SetGameViewModel.Card, array: [SetGameViewModel.Card]) -> Double {
        let value: Int = game.deck.firstIndex(where: {$0.id == card.id}) ?? 0
        if value % 2 == 0 {
            return Double(value)
        }
            else {
                return -Double(value)
            }
    }
    
    private func zIndex (of card: SetGameViewModel.Card, array: [SetGameViewModel.Card]) -> Double {
        -Double(array.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var deck: some View {
        ZStack {
            ForEach(game.deck) { card in
                Group {
                RoundedRectangle(cornerRadius: 10).fill(Color.red)
                    RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 0.5).foregroundColor(Color(.black))
                }
                .offset(x: CGFloat(placecards(of: card, array: game.deck)))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .zIndex(zIndex(of: card, array: game.deck))
            }
        }
            .frame(width: 75 * 3/2, height: 75 )
            
            .onTapGesture {
                withAnimation {
                    game.addThreeCards()
                }
            }
        
    }

    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
//        game.choose(game.cards.first!)
        return SetGame_View(game: game)
            .preferredColorScheme(.light)
       
    }
}

