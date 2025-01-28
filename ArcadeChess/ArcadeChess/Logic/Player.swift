//
//  Player.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 28/01/25.
//
import SwiftUI

struct Player {
    var pieces: [Piece]
    var type: PlayerType
    var selectedPiece: Piece?
    
    init(_ type: PlayerType) {
        self.type = type
        self.pieces = Piece.initialPieces(for: type)
    }
    
    func pieceResource(_ piece: Piece) -> ImageResource {
        switch piece.type {
        case .king:
            return type == .black ? .chessKdt60 : .chessKlt60
        case .queen:
            return type == .black ? .chessQdt60 : .chessQlt60
        case .bishop:
            return type == .black ? .chessBdt60 : .chessBlt60
        case .rook:
            return type == .black ? .chessRdt60 : .chessRlt60
        case .knight:
            return type == .black ? .chessNdt60 : .chessNlt60
        case .pawn:
            return type == .black ? .chessPdt60 : .chessPlt60
        }
    }
}

enum PlayerType {
    case black
    case white
}
