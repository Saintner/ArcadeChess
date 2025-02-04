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
    
    private var piecesPosition: [Coordinates: Piece] = [:]
    
    private var currentlyPlaying: PieceColor = .white
    private var currentState: GameState = .whitePicking
    
    init() {
        whitePlayer = .init(.white)
        blackPlayer = .init(.black)
        board = Board()
    }
    
    func piece(for rank: Rank, file: File) -> Piece {
        board.piece(for: rank, and: file, is: currentlyPlaying)
    }
    
    func selectPiece(at coordinates: Coordinates) {
        switch currentState {
        case .whitePicking:
            pick(coordinates: coordinates, newState: .whitePicked)
        case .whitePicked:
            place(&whitePlayer, enemy: blackPlayer, coordinates: coordinates, newState: .whitePicking)
        case .blackPicking:
            pick(coordinates: coordinates, newState: .blackPicked)
        case .blackPicked:
            place(&blackPlayer, enemy: whitePlayer, coordinates: coordinates, newState: .whitePicking)
        }
    }
    
    private func pick(coordinates: Coordinates, newState: GameState) {
        if board.hasSelectedPiece(at: coordinates, is: currentlyPlaying) {
            currentState = newState
        }
    }
    
    private func place(_ player: inout Player, enemy: Player, coordinates: Coordinates, newState: GameState) {
        if board.didMove(to: coordinates) {
            currentState = newState
        }
//        if player.selectedPiece!.canMove(to: coordinates) {
//            if player.selectedPiece!.type != .knight {
//                let involveCoordinates = player.selectedPiece!.involveCoordinates(with: coordinates)
//                if !isInterveningPieces(in: involveCoordinates) {
//                    if player.pieces.checkPlacementAvailability(for: coordinates) {
//                        movePiece(for: &player, newState: newState, and: coordinates)
//                    }
//                }
//            } else {
//                if player.pieces.checkPlacementAvailability(for: coordinates) {
//                    movePiece(for: &player, newState: newState, and: coordinates)
//                }
//            }
//            
//        }
    }
    
//    private func movePiece( for player: inout Player, newState: GameState, and coordinates: Coordinates) {
//        player.pieces.removeAll { piece in
//            player.selectedPiece!.coordinates == piece.coordinates
//        }
//        player.selectedPiece!.coordinates = coordinates
//        player.pieces.append(player.selectedPiece!)
//        player.selectedPiece = nil
//        currentState = newState
//    }
    
//    private func isInterveningPieces(in coordinates: [Coordinates]) -> Bool {
//        let allPiecesInBoard = whitePlayer.pieces + blackPlayer.pieces
//        var hasIterveningPiece = false
//        for coordinate in coordinates {
//            hasIterveningPiece = allPiecesInBoard.contains(where: { $0.coordinates == coordinate })
//            if hasIterveningPiece {
//                break
//            }
//        }
//        return hasIterveningPiece
//    }
}
