//
//  SetGameModel.swift
//  SetGame
//
//  Created by Max Lyu on 2023/9/25.
//

import Foundation

struct DeckSetCard{
    
    var cards: Array<SetCard>
    
    var visibleCards: Array<SetCard>
    
    var currentlyChoosenCards: Array<SetCard> = []
        
    var matched: Int
    
    var numCardsChoosen: Int {
        var num: Int = 0
        
        for card in visibleCards{
            if card.isChoosen{
                num += 1
            }
        }
        
        return num
    }
    
    
    init(convert visibleCardID: Array<Int>, using convertToCard: (Int) -> SetCard){
        cards = Array<SetCard>()
        visibleCards = Array<SetCard>()
        
        for card_id in 0...80{
            cards.append(convertToCard(card_id))
        }
        
        for card_index in visibleCardID.indices{
            cards[visibleCardID[card_index]].isVisible = true
            visibleCards.append(convertToCard(visibleCardID[card_index]))
        }
        
        matched = 0

    }
    
    
    mutating func choose(_ card: SetCard){
//        for i in cards.indices{
//            if cards[i].id == card.id{
//                cards[i].isChoosen.toggle()
//                print("Card of id \(cards[i].id) toggles")
//            }
//        }
        if numCardsChoosen < 3{
            for i in visibleCards.indices{
                if visibleCards[i].id == card.id{
                    if !currentlyChoosenCards.contains(where: {$0.id == card.id}) {
                        currentlyChoosenCards.append(card)
                    } else {
                        currentlyChoosenCards.removeAll(where: {$0.id == card.id})
                    }
                    visibleCards[i].isChoosen.toggle()
                    cards[visibleCards[i].id].isChoosen.toggle()
                    print("Card of id \(visibleCards[i].id) toggles; Number of cards choosen: \(numCardsChoosen)")
                    print("Current choosen cards are: \(currentlyChoosenCards)")
                }
            }
        }
        if numCardsChoosen == 3 {
            if matching(currentlyChoosenCards[0],currentlyChoosenCards[1],currentlyChoosenCards[2]){
                disselectAll(matched: true)
                matched += 3
            } else{
                disselectAll(matched: false)
            }
        }
//        for i in visibleCards.indices{
//            if numCardsChoosen < 3{
//                if visibleCards[i].id == card.id{
//                    if !currentlyChoosenCards.contains(where: {$0.id == card.id}) {
//                        currentlyChoosenCards.append(card)
//                    } else {
//                        currentlyChoosenCards.removeAll(where: {$0.id == card.id})
//                    }
//                    visibleCards[i].isChoosen.toggle()
//                    cards[visibleCards[i].id].isChoosen.toggle()
//                    print("Card of id \(visibleCards[i].id) toggles; Number of cards choosen: \(numCardsChoosen)")
//                    print("Current choosen cards are: \(currentlyChoosenCards)")
//                }
//            } else{
//                if matching(currentlyChoosenCards[0],currentlyChoosenCards[1],currentlyChoosenCards[2]){
//                    disselectAll(matched: true)
//                } else{
//                    disselectAll(matched: false)
//                }
//            }
//
//        }
    }
    
    mutating func disselectAll(matched: Bool){
        for i in currentlyChoosenCards{
            cards[i.id].isMatched = matched
            cards[i.id].isChoosen = false
            cards[i.id].isVisible = !matched
            for j in visibleCards.indices{
                if visibleCards[j].id == i.id{
                    visibleCards[j].isChoosen = false
                }
            }
            if matched{
                visibleCards.removeAll(where: {$0.id==i.id})
            } else{
                print("NO MATCH. DISSELECTING ALL")
            }
            currentlyChoosenCards.removeAll(where: {$0.id == i.id})
        }
    }
    
    func matching(_ c1: SetCard, _ c2: SetCard, _ c3: SetCard) -> Bool{
        var result: Bool = true
        for i in 0...3{
            if c1.property[i] == c2.property[i] && c1.property[i] == c3.property[i]{
                print("Property \(i) all same")
            } else if c1.property[i] != c2.property[i] && c1.property[i] != c3.property[i] && c2.property[i] != c3.property[i] {
                print("Property \(i) all differet")
            } else{
                print("Property \(i) doesn't qualify!!!")
                result = false
            }
        }
        
        return result
    }
    
    
    mutating func drawCard(){
        if matched + visibleCards.count <= 78{
            for _ in 0...2{
                var new_card_id: Int
                
                repeat{
                    new_card_id = Int.random(in: 0...80)
                } while cards[new_card_id].isVisible || cards[new_card_id].isMatched
                
                cards[new_card_id].isVisible = true
                visibleCards.append(cards[new_card_id])
                print("Draw a new card of id \(new_card_id)")
            }
        }
        
    }
    
    
    struct SetCard: Identifiable{
        
        init(id: Int){
            self.id = id
        }
        
        
        /*
         Given an id, it uniquely identifies the card, and it includes all information about the cards property.
         Four properties in total: color, shade, shape, number
         - We can interpret the four properties into a series of 4 numbers, where each number corresponds to one feature
         - Since there are three possibilities to each feature, each number can be denoted by 0, 1, 2
         - Then, the id can be represented as a 4-digit trenary number (e.g. id = 39 = 1110 in trenary)
        */
        
        var property: [Int] {
            let number_id = id % 3
            let shape_id = (id - number_id)/3 % 3
            let shade_id = ((id - number_id)/3 - shape_id)/3 % 3
            let color_id = (((id - number_id)/3 - shape_id)/3 - shade_id) / 3
            
            return [color_id, shade_id, shape_id, number_id]
        }
        
        var isChoosen: Bool = false
        var isMatched: Bool = false
        var isVisible: Bool = false
        var id: Int = 0
        
    }
    
}



