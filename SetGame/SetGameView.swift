//
//  ContentView.swift
//  SetGame
//
//  Created by Max Lyu on 2023/9/25.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var viewModel: SetGameVM = SetGameVM()
    
    var body: some View {
        VStack{
            Text(String(viewModel.matched))
            cards
            Button("Draw 3 Cards"){
                viewModel.drawCard()
            }
        }
        
        
    }
    
//    var score: some View{
//        Text(viewModel.matched)
//    }
    
    var cards: some View{
        
        AspectVGrid(viewModel.visibleCards, aspectRatio: 2/3) { card in
            SetCardView(card)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
