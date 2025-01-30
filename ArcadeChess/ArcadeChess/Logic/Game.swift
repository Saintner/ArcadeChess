//
//  Game.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 27/01/25.
//
import SwiftUI
//protocol Coordinatable: Hashable {
//    var rank: Rank { get set }
//    var file: File { get set }
//}
struct Coordinates: Hashable {
    var rank: Rank
    var file: File
}

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
    
    func check(coordinates: Coordinates) -> Bool {
        var positions = whitePlayer.pieces
        positions.append(contentsOf: blackPlayer.pieces)
        return positions.contains(where: { $0.coordinates == coordinates })
    }
    
    func pieceImage(for coordinates: Coordinates) -> some View {
        let whitePice = whitePlayer.pieces.first { $0.coordinates == coordinates }
        let blackPiece = blackPlayer.pieces.first { $0.coordinates == coordinates }
        if let whitePice = whitePice {
            return Image(whitePlayer.pieceResource(whitePice)).resizable().frame(width: 35, height: 35)
        } else {
            return Image(blackPlayer.pieceResource(blackPiece!)).resizable().frame(width: 35, height: 35)
        }
    }
    
    func selectPiece(at coordinates: Coordinates) {
        print(currentState)
        switch currentState {
        case .whitePicking:
            pick(&whitePlayer, coordinates: coordinates, newState: .whitePicked)
        case .whitePicked:
            place(&whitePlayer, enemy: blackPlayer, coordinates: coordinates, newState: .blackPicking)
        case .blackPicking:
            pick(&blackPlayer, coordinates: coordinates, newState: .blackPicked)
        case .blackPicked:
            place(&blackPlayer, enemy: whitePlayer, coordinates: coordinates, newState: .whitePicking)
        }
    }
    
    private func pick(_ player: inout Player, coordinates: Coordinates, newState: GameState) {
        if let playerPiece = player.pieces.first(where: { $0.coordinates == coordinates }) {
            player.selectedPiece = playerPiece
            currentState = newState
        }
    }
    
    private func place(_ player: inout Player, enemy: Player, coordinates: Coordinates, newState: GameState) {
        if player.selectedPiece!.canMove(to: coordinates) && !enemy.pieces.checkEnemy(from: player.selectedPiece!.coordinates, to: coordinates) {
            player.pieces.removeAll { piece in
                player.selectedPiece!.coordinates == piece.coordinates
            }
            player.selectedPiece!.coordinates = coordinates
            player.pieces.append(player.selectedPiece!)
            player.selectedPiece = nil
            currentState = newState
        }
    }
}
