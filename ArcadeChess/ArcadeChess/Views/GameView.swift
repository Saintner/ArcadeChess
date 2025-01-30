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
                        if game.check(coordinates: Coordinates(rank: rank, file: file)) {
                            game.pieceImage(for: Coordinates(rank: rank, file: file))
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

struct Board {
    let files = File.allCases
    let ranks = Rank.allCases
    let squareSize: CGFloat = 45 // Size of each square
}

protocol PointIterable: CaseIterable, Hashable, RawRepresentable {
    
}

extension PointIterable where RawValue == Int {
    var value: Int {
        return self.rawValue
    }
}

enum Rank: Int, PointIterable {
    case one, two, three, four, five, six, seven, eight

}

enum File: Int, PointIterable {
    case a, b, c, d, e, f, g, h
}
