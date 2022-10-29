//
//  ContentView.swift
//  Snake
//
//  Created by Rafael Almeida on 10/26/22.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel(viewHeight: UIScreen.main.bounds.height,
                                               viewWidth: UIScreen.main.bounds.width)
    var body: some View {
        VStack(spacing: 60) {
            VStack(spacing: 0) {
                ForEach(viewModel.matrix, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { square in
                            switch square {
                            case .snake:
                                Rectangle()
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .foregroundColor(Color("blue"))
                                    .shadow(color: Color("blue"), radius: 5, x: 0, y: 0)
                                    .border(.gray, width: 1)
                            case .empty:
                                Rectangle()
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .foregroundColor(Color("white"))
                            case .food:
                                Rectangle()
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .foregroundColor(Color("red"))
                                    .shadow(color: Color("red"), radius: 5, x: 0, y: 0)
                                    .border(.gray, width: 1)
                            }
                        }
                    }
                }
            }
            .border(Color("red"), width: 10)
            .cornerRadius(10)
            .clipped()
            .shadow(color: Color("red"), radius: 10, x: 0, y: 0)
            
            VStack(spacing: 0) {
                Button {
                    viewModel.userMovment(direction: .up)
                } label: {
                    Image(systemName: "arrowtriangle.up.fill")
                        .padding(.all, 20)
                        
                }
                .buttonStyle(.borderedProminent)
                
                HStack(spacing: 70) {
                    Button {
                        viewModel.userMovment(direction: .left)
                    } label: {
                        Image(systemName: "arrowtriangle.left.fill")
                            .padding(.all, 20)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        viewModel.userMovment(direction: .right)
                    } label: {
                        Image(systemName: "arrowtriangle.right.fill")
                            .padding(.all, 20)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                Button {
                    viewModel.userMovment(direction: .down)
                } label: {
                    Image(systemName: "arrowtriangle.down.fill")
                        .padding(.all, 20)
                }
                .buttonStyle(.borderedProminent)
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
