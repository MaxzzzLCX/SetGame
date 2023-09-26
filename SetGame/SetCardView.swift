//
//  SetCardView.swift
//  SetGame
//
//  Created by Max Lyu on 2023/9/25.
//

import SwiftUI

/*
 This the a separate SwiftUI View document that designs the View of an individual card
 */

struct SetCardView: View {
    
    typealias Card = DeckSetCard.SetCard
    var card: Card
    
    var card_color: Color{
        if card.property[0] == 0{
            return .green
        }else if card.property[0] == 1{
            return .red
        }else{
            return .blue
        }
    }
    
    
    var card_shade: Double{
        if card.property[1] == 0 {
            return 1
        } else if card.property[1] == 1 {
            return 0.5
        } else{
            return 0
        }
    }
    
    
    var card_number: Int{
        return card.property[3] + 1
    }
    
    var card_content_element: some View{
        ZStack{
            ZStack{
                Ellipse().stroke(lineWidth: 5)
                    .foregroundColor(card_color)
                Ellipse().fill(card_color)
                    .opacity(card_shade)
            }
            .opacity(card.property[2]==0 ? 1 : 0)
            ZStack{
                Rectangle().stroke(lineWidth: 5)
                    .foregroundColor(card_color)
                Rectangle().fill(card_color)
                    .opacity(card_shade)
            }
            .opacity(card.property[2]==1 ? 1 : 0)
            ZStack{
                Circle().stroke(lineWidth: 5)
                    .foregroundColor(card_color)
                Circle().fill(card_color)
                    .opacity(card_shade)
            }
            .opacity(card.property[2]==2 ? 1 : 0)
        }
        .padding(5)
    }
    
    var card_content: some View{
        VStack{
            card_content_element
                .opacity(card_number>=1 ? 1 : 0)
            card_content_element
                .opacity(card_number>=2 ? 1 : 0)
            card_content_element
                .opacity(card_number>=3 ? 1 : 0)
        }
    }
    
    
    
    
    
    
    init(_ card: Card){
        self.card = card
    }
    
    
    
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            base.strokeBorder(lineWidth: 5)
                .foregroundColor(card.isChoosen ? .orange : .black)
                .background(base.fill(.white))
                
            VStack{
                card_content
                
            }
            .padding(7)

        }
        .padding(5)
    }
}

struct SetCardView_Previews: PreviewProvider {
    
    typealias Card = DeckSetCard.SetCard
    
    static var previews: some View {
        HStack{
            VStack{
                SetCardView(Card(id: 0))
                SetCardView(Card(id: 9))
            }
            VStack{
                SetCardView(Card(id: 18))
                SetCardView(Card(id: 66))
            }
        }
    }
}
