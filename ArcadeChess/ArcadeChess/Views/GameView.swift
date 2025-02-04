//
//  GameView.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 20/01/25.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: Game = Game()
    var body: some View {
        VStack(spacing: 0) {
            ForEach(game.board.ranks, id: \.self) { rank in
            HStack(spacing: 0) {
                ForEach(game.board.files, id: \.self) { file in
                    ZStack {
                        Rectangle()
                            .fill((rank.value + file.value) % 2 == 0 ? Color.white : Color.brown)
                            .frame(width: game.board.squareSize, height: game.board.squareSize)
                        if game.board.isDrawingPiece(for: rank, and: file) {
                            Image(.piece(game.piece(for: rank, file: file))).resizable().frame(width: 35, height: 35)
                        }
                    }.onTapGesture {
                        game.selectPiece(at: Coordinates(rank: rank, file: file))
                    }
                }
            }
        }
    }
    .border(Color.gray, width: 2)
    }
}
