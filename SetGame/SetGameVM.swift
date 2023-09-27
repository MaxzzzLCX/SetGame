//
//  SetGameVM.swift
//  SetGame
//
//  Created by Max Lyu on 2023/9/25.
//

import SwiftUI

class SetGameVM: ObservableObject{
    
    typealias SetCard = DeckSetCard.SetCard
    
    private static var visibleCards: [Int] = randomArrayOfIDs(num: 12)
    
    static func randomArrayOfIDs (num: Int) -> [Int]{
        
        var randomIDs: Array<Int> = []
        
        for _ in 0..<num{
            var id: Int
            repeat{
                id = Int.random(in: 0...80)
            } while randomIDs.contains(id)
            
            randomIDs.append(id)
        }
        
        return randomIDs
    }
    
    private static func createSetGame() -> DeckSetCard{
        return DeckSetCard(convert: visibleCards, using: setCardConvertion)
        
        func setCardConvertion (id: Int) -> SetCard{

            return SetCard(id: id)
        }
    }
    
    @Published private var model = SetGameVM.createSetGame()
    
    var cards: Array<SetCard>{
        model.cards
    }
    
    var matched: Int{
        model.matched
    }
    
    var visibleCards: Array<SetCard>{
        return model.visibleCards
//        var newVisibleCards: [SetCard] = []
//
//        for i in 0..<cards.count{
//            if cards[i].isVisible{
//                newVisibleCards.append(cards[i])
//            }
//        }
    }
    
    //MARK: Intents
    
    func choose(_ card: SetCard){
        model.choose(card)
    }
    
    func drawCard(){
        model.drawCard()
    }
        
        
    
}
