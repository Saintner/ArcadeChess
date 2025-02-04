//
//  ImageResource+PieceExtension.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 3/02/25.
//

import SwiftUI

extension ImageResource {
    static func piece(_ piece: Piece) -> ImageResource {
        switch piece.type {
       case .king:
            return piece.color == .black ? .chessKdt60 : .chessKlt60
       case .queen:
            return piece.color == .black ? .chessQdt60 : .chessQlt60
       case .bishop:
            return piece.color == .black ? .chessBdt60 : .chessBlt60
       case .rook:
            return piece.color == .black ? .chessRdt60 : .chessRlt60
       case .knight:
            return piece.color == .black ? .chessNdt60 : .chessNlt60
       case .pawn:
            return piece.color == .black ? .chessPdt60 : .chessPlt60
       }
    }
}
