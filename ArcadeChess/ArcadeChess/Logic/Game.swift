//
//  Game.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 27/01/25.
//
import SwiftUI

enum GameState {
    case whitePicking
    case whitePicked
    case blackPicking
    case blackPicked
}

class Game: ObservableObject {
    @Published var whitePlayer: Player
    @Published var blackPlayer: Player
    @Published var board: Board
    
    private var currentlyPlaying: PlayerType = .white
    private var currentState: GameState = .whitePicking
    
    init() {
        whitePlayer = .init(.white)
        blackPlayer = .init(.black)
        board = Board()
    }
    
    func check(row: Int, and column: Int) -> Bool {
        let position = Position(row: row, column: column)
        var positions = whitePlayer.pieces
        positions.append(contentsOf: blackPlayer.pieces)
        return positions.contains(where: { $0.position == position })
    }
    
    func pieceImage(at row: Int, and column: Int) -> some View {
        let position = Position(row: row, column: column)
        let whitePice = whitePlayer.pieces.first { $0.position == position }
        let blackPiece = blackPlayer.pieces.first { $0.position == position }
        if let whitePice = whitePice {
            return Image(whitePlayer.pieceResource(whitePice)).resizable().frame(width: 35, height: 35)
        } else {
            return Image(blackPlayer.pieceResource(blackPiece!)).resizable().frame(width: 35, height: 35)
        }
    }
    
    func selectPiece(at row: Int, and column: Int) {
        let position = Position(row: row, column: column)
        print(currentState)
        switch currentState {
        case .whitePicking:
            pick(&whitePlayer, position: position, newState: .whitePicked)
        case .whitePicked:
            place(&whitePlayer, position: position, newState: .blackPicking)
        case .blackPicking:
            pick(&blackPlayer, position: position, newState: .blackPicked)
        case .blackPicked:
            place(&blackPlayer, position: position, newState: .whitePicking)
        }
    }
    
    private func pick(_ player: inout Player, position: Position, newState: GameState) {
        if let playerPiece = player.pieces.first(where: { $0.position == position }) {
            player.selectedPiece = playerPiece
            currentState = newState
        }
    }
    
    private func place(_ player: inout Player, position: Position, newState: GameState) {
        if player.selectedPiece!.canMove(to: position) {
            player.pieces.removeAll { piece in
                player.selectedPiece?.position == piece.position
            }
            player.selectedPiece!.position = position
            player.pieces.append(player.selectedPiece!)
            player.selectedPiece = nil
            currentState = newState
        }
    }
}
