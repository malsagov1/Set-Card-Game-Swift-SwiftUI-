//
//
//
//
//  Created by Умар Мальсагов on 23.10.2021.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame.Card
  
    
    @Published private var model = SetGame()
    var cards: Array<SetGame.Card>{
        return model.cards
    }
    var cardpile: Array<SetGame.Card>{
        return model.cardpile
    }
    var deck: Array<SetGame.Card> {
        return model.Deck
    }
    
  

    // MARK: - Intent(s)
  func choose (_ card: SetGame.Card)
  {
    model.choose(card)
  }
    func createNewgame () {
        model = SetGame()
    }

    func addThreeCards () {
        model.addCards(numberofCardstoAdd: 3)
    }
}


