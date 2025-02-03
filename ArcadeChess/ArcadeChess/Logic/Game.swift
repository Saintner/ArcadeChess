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
    
    init(rank: Rank, file: File) {
        self.rank = rank
        self.file = file
    }
    
    init(rank: Int, file: Int) {
        self.rank = Rank(value: rank)
        self.file = File(value: file)
    }
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
    
    private var piecesPosition: [Coordinates: Piece] = [:]
    
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
        switch currentState {
        case .whitePicking:
            pick(&whitePlayer, coordinates: coordinates, newState: .whitePicked)
        case .whitePicked:
            place(&whitePlayer, enemy: blackPlayer, coordinates: coordinates, newState: .whitePicking)
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
        if player.selectedPiece!.canMove(to: coordinates) {
            if player.selectedPiece!.type != .knight {
                let involveCoordinates = player.selectedPiece!.involveCoordinates(with: coordinates)
                if !isInterveningPieces(in: involveCoordinates) {
                    if player.pieces.checkPlacementAvailability(for: coordinates) {
                        movePiece(for: &player, newState: newState, and: coordinates)
                    }
                }
            } else {
                if player.pieces.checkPlacementAvailability(for: coordinates) {
                    movePiece(for: &player, newState: newState, and: coordinates)
                }
            }
            
        }
    }
    
    private func movePiece( for player: inout Player, newState: GameState, and coordinates: Coordinates) {
        player.pieces.removeAll { piece in
            player.selectedPiece!.coordinates == piece.coordinates
        }
        player.selectedPiece!.coordinates = coordinates
        player.pieces.append(player.selectedPiece!)
        player.selectedPiece = nil
        currentState = newState
    }
    
    private func isInterveningPieces(in coordinates: [Coordinates]) -> Bool {
        let allPiecesInBoard = whitePlayer.pieces + blackPlayer.pieces
        var hasIterveningPiece = false
        for coordinate in coordinates {
            hasIterveningPiece = allPiecesInBoard.contains(where: { $0.coordinates == coordinate })
            if hasIterveningPiece {
                break
            }
        }
        return hasIterveningPiece
    }
}
