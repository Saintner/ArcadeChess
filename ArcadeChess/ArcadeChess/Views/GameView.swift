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
            ForEach(game.board.rows, id: \.self) { row in
            HStack(spacing: 0) {
                ForEach(game.board.columns.indices, id: \.self) { column in
                    ZStack {
                        Rectangle()
                            .fill((row + column) % 2 == 0 ? Color.white : Color.brown)
                            .frame(width: game.board.squareSize, height: game.board.squareSize)
                        if game.check(row: row, and: column) {
                            game.pieceImage(at: row, and: column)
                        }
                    }.onTapGesture {
                        game.selectPiece(at: row, and: column)
                    }
                }
            }
        }
    }
    .border(Color.gray, width: 2)
    }
}



struct Position: Hashable {
    var row, column: Int
}

struct Board {
    let columns = ["a", "b", "c", "d", "e", "f", "g", "h"]
    let rows = [8, 7, 6, 5, 4, 3, 2, 1]
    let squareSize: CGFloat = 45 // Size of each square
}

