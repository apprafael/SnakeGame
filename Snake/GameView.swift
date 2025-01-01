//
//  ContentView.swift
//  Snake
//
//  Created by Rafael Almeida on 10/26/22.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()

    var body: some View {
        ZStack {

            setContent()

            if !viewModel.gameStarted {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()

                Button(action: {
                    viewModel.startGame()
                }, label: {
                    Image("start")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                })
            }
        }
    }

    private func setContent() -> some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .overlay(Color.black.opacity(0.5))

            VStack(spacing: 60) {
                setGameGrid()
                setDPad()
            }
            .padding()
//            .onAppear {
//                viewModel.playGame()
//            }
            .onDisappear {
                viewModel.pauseGame()
            }
        }

    }

    private func setGameGrid() -> some View {
        VStack(spacing: 0) {
            ForEach(viewModel.matrix, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id: \.self) { square in
                        switch square {
                        case .snake:
                            Image("snake_piece")
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                                .shadow(color: .blue, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        case .empty:
                            Rectangle()
                                .aspectRatio(1.0, contentMode: .fit)
                                .foregroundColor(.clear)
                        case .food:
                            Image("food")
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                                .shadow(color: .blue, radius: 10)
                        case .growthPotion:
                            Image("red-potion")
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                                .shadow(color: .red, radius: 10)
                        case .speedPotion:
                            Image("green-potion")
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fit)
                                .shadow(color: .green, radius: 10)
                        }
                    }
                }
                .foregroundColor(.blue.opacity(0.5))
            }
        }
        .clipped()
        .background {
            ZStack {
                Image("grid_background")
                    .resizable()
                    .overlay(Color.black.opacity(0.5))
            }
            .cornerRadius(10)
            .shadow(color: .blue, radius: 10)
        }
    }

    private func setDPad() -> some View {
        VStack(spacing: 0) {
            Button {
                viewModel.userMovement(direction: .up)
            } label: {
                Image("dPadButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .rotationEffect(.degrees(-90))
            }

            HStack(spacing: 70) {
                Button {
                    viewModel.userMovement(direction: .left)
                } label: {
                    Image("dPadButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .rotationEffect(.degrees(-180))

                }

                Button {
                    viewModel.userMovement(direction: .right)
                } label: {
                    Image("dPadButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
            }

            Button {
                viewModel.userMovement(direction: .down)
            } label: {
                Image("dPadButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .rotationEffect(.degrees(-270))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
