//
//  Array+PieceProtocolExtension.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 3/02/25.
//

extension Array where Element: PieceProtocol {
    func checkEnemy(from a: Coordinates, to b: Coordinates) -> Bool {
        let result = self.first { piece in
            piece.coordinates == b
        }
        return result != nil
    }
    
    func checkPlacementAvailability(for coordinates: Coordinates) -> Bool {
        return self.allSatisfy { $0.coordinates != coordinates }
    }
    
    static func initialPieces() -> [Piece] {
        let blackPieces = Piece.initialPieces(for: .black)
        var whitePieces = Piece.initialPieces(for: .white)
        whitePieces.append(contentsOf: blackPieces)
        return whitePieces
    }
}
