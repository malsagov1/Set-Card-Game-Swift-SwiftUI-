//
//  MemoryGame.swift
//  Memorize
//
//  Created by Умар Мальсагов on 23.10.2021.
//

import Foundation

struct SetGame {
    private(set) var cards: Array<Card>
    
   private(set) var Deck: [Card] = []
    private(set) var cardpile: [Card] = []
    private var selectedID: [Int] = []
    var wasmatched: Bool = false
    
    mutating func choose (_ card: Card){
        if var chosenIndex = cards.firstIndex(where:{ $0.id == card.id}) {
            
            if cards[chosenIndex].status == nil || cards[chosenIndex].status == States.State2  {
                cards[chosenIndex].status = States.State1
                if selectedID.count == 3 {
                    let reversedSelectedId = selectedID.sorted().reversed()
                    for id in reversedSelectedId {
                            if wasmatched {
                                
                                    if !Deck.isEmpty {
                                        cards[id].status = nil
                                        cardpile.append(cards[id])
                                        cards[id] = Deck[0]
                                        Deck.remove(at: 0)
                                    }
                                    else {
                                        cards[id].status = nil
                                        cardpile.append(cards[id])
                                    cards.remove(at: id)
                                    }
                           
                            }
                            else {
                                    if cards[id].status != States.State1 {
                                        cards[id].status = nil
                                    }
                            }
                    }
                    selectedID = []
                    chosenIndex = cards.firstIndex(where: { $0.status == States.State1})!
                }
                
                selectedID.append(chosenIndex)
                if selectedID.count == 3 {
                        for id in selectedID {
                            if match() {
                            cards[id].status = States.State3
                                wasmatched = true
                        }
                            else {
                            cards[id].status = States.State2
                                
                        }
    
                    }
                        
                } else {
                    wasmatched = false
                }
              
            }
            else {
                    if cards[chosenIndex].status != States.State3 {
                        cards[chosenIndex].status = nil
                        selectedID.remove(at: selectedID.firstIndex(of: chosenIndex)!)
            }
               
            }
        }
    }
    
    
    func match () -> Bool {
        let colorSet = Set(arrayLiteral: cards[selectedID[0]].color, cards[selectedID[1]].color, cards[selectedID[2]].color)
        let shadingSet = Set(arrayLiteral: cards[selectedID[0]].Shading, cards[selectedID[1]].Shading, cards[selectedID[2]].Shading)
        let numberSet = Set(arrayLiteral: cards[selectedID[0]].numberOfShapes, cards[selectedID[1]].numberOfShapes, cards[selectedID[2]].numberOfShapes)
        let shapeSet = Set(arrayLiteral: cards[selectedID[0]].Shapes, cards[selectedID[1]].Shapes, cards[selectedID[2]].Shapes)

        if colorSet.count == 1 || colorSet.count == 3,
            shadingSet.count == 1 || shadingSet.count == 3,
            numberSet.count == 1 || numberSet.count == 3,
            shapeSet.count == 1 || shapeSet.count == 3 {
                return true
        }
        else {
            return false
            
        }

        }
        
        
    
    init () {
    var index = 0
    for stateofColor in States.allCases {
        for stateofnumberShapes in States.allCases {
            for stateofShapes in States.allCases {
                for stateofShading in States.allCases {
                    Deck.append(Card(color: stateofColor, numberOfShapes: stateofnumberShapes,
                                     Shapes: stateofShapes, Shading: stateofShading, id: index))
                    index += 1
                }
            }
        }
    }
        Deck.shuffle()
        cards = []
      
    }
    

    mutating func addCards (numberofCardstoAdd: Int) {
        if wasmatched, !selectedID.isEmpty{
            for id in selectedID {
                cards[id].status = nil
                cardpile.append(cards[id])
                if !Deck.isEmpty {
                    cards[id] = Deck[0]
                    Deck.remove(at: 0)
                }
            }
            selectedID = []
        }
        else {
            for _ in 0..<numberofCardstoAdd   {
                 if !Deck.isEmpty {
                cards.append(Deck[0])
                    Deck.remove(at: 0)
                      }
                }
        }
    }
        
    
    struct Card: Equatable, Identifiable {
        let color, numberOfShapes, Shapes, Shading: States
        var isMatched: Bool = false
        let id: Int
        var status: States?
    }
    
}

enum States: CaseIterable, Hashable {
        case State1
        case State2
        case State3
    }
