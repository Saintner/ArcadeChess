//
//  Board.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 3/02/25.
//

import Foundation

class Board {
    let files = File.allCases
    let ranks = Rank.allCases
    var pieces: [Piece] = .initialPieces()
    let squareSize: CGFloat = 45 // Size of each square
    var selectedPiece: Piece? = nil
    
    func hasSelectedPiece(at coordinates: Coordinates, is color: PieceColor) -> Bool {
        if let piece = pieces.first(where: { $0.coordinates == coordinates }) {
            self.selectedPiece = piece
            return piece.color == color
        }
        return false
    }
    
    func isDrawingPiece(for rank: Rank, and file: File) -> Bool {
        let coordinates = Coordinates(rank: rank, file: file)
        return pieces.first(where: { $0.coordinates == coordinates}) != nil
    }
    
    func piece(for rank: Rank, and file: File, is pieceColor: PieceColor) -> Piece {
        let coordinates = Coordinates(rank: rank, file: file)
        let whitePice = pieces.first { $0.coordinates == coordinates && $0.color == pieceColor }
        let blackPiece = pieces.first { $0.coordinates == coordinates }
        if let whitePice = whitePice {
            return whitePice
        } else {
            return blackPiece!
        }
    }
    
    func didMove(to coordinates: Coordinates) -> Bool {
        guard var selectedPiece = self.selectedPiece else { return false }
        let movementDone = selectedPiece.coordinates.didMakeMovement(to: coordinates)
        guard movementDone != .none,
              selectedPiece.movementsAllowed.contains(where: {$0 == movementDone }),
              selectedPiece.isAllowedDistance(to: coordinates) else { return false }
        let path = path(from: selectedPiece.coordinates, to: coordinates)
        let currentCoordinates = pieces.compactMap({ $0.coordinates })
        let isPathBlocked = path.contains { coord in
            pieces.contains { pie in
                pie.coordinates == coord
            }
        }
        if isPathBlocked && selectedPiece.type != .knight { return false }
        pieces.removeAll { p in
            p == selectedPiece
        }
        selectedPiece.coordinates = coordinates
        pieces.append(selectedPiece)
        self.selectedPiece = nil
        print("allowed")
        return true
    }
    
    private func path(from origin: Coordinates, to destination: Coordinates) -> [Coordinates] {
        let startRank = origin.rank.value
        let startFile = origin.file.value
        let endRank = destination.rank.value
        let endFile = destination.file.value
        let rankStep = (endRank - startRank == 0) ? 0 : (endRank > startRank ? 1 : -1)
        let fileStep = (endFile - startFile == 0) ? 0 : (endFile > startFile ? 1 : -1)
        var currentRank = origin.rank.value + rankStep
        var currentFile = origin.file.value + fileStep
        
        var involvedCoordinates: [Coordinates] = []
        while currentRank != destination.rank.value || currentFile != destination.file.value {
            involvedCoordinates.append(Coordinates(rank: currentRank, file: currentFile))
            currentFile += fileStep
            currentRank += rankStep
        }
        return involvedCoordinates
    }
    
//    func canMove(to coordinates: Coordinates) -> {
//
//    }
}
