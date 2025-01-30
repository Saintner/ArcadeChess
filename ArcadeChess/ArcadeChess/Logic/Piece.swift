//
//  Piece.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 28/01/25.
//

protocol PieceProtocol: Hashable {
    var coordinates: Coordinates { get set }
}
struct Piece: PieceProtocol {
    var type: PieceType
    var coordinates: Coordinates
    
    func canMove(to destination: Coordinates) -> Bool {
        var result = false
        result = self.coordinates != destination
        let fileDiff = abs(coordinates.file.rawValue - destination.file.rawValue)
        let rankDiff = abs(coordinates.rank.rawValue - destination.rank.rawValue)
        switch type {
        case .king:
            result = fileDiff == 1 || rankDiff == 1
        case .queen:
            break
        case .bishop:
            result = coordinates.file != destination.file && coordinates.rank != destination.rank
            result = fileDiff == rankDiff
        case .knight:
            result = (fileDiff == 1 && rankDiff == 2) || (fileDiff == 2 && rankDiff == 1)
        case .rook:
            result = coordinates.file != destination.file && coordinates.rank == destination.rank
            result = coordinates.file == destination.file && coordinates.rank != destination.rank
        case .pawn:
            result = fileDiff == 0 && rankDiff == 1
        }
        return result
    }
}

extension Array where Element: PieceProtocol {
    func checkEnemy(from a: Coordinates, to b: Coordinates) -> Bool {
        let result = self.first { piece in
            piece.coordinates == b
        }
        return result != nil
    }
}

enum PieceType {
    case king
    case queen
    case bishop
    case knight
    case rook
    case pawn
}

extension Piece {
    
    static func initialPieces(for playerType: PlayerType) -> [Piece] {
        let nonPawnRow: Rank = playerType == .white ? .eight : .one
        let pawnsRow: Rank = playerType == .white ? .seven : .two
        return [Piece(type: .rook, coordinates: Coordinates(rank: nonPawnRow, file: .a)),
                Piece(type: .knight, coordinates: Coordinates(rank: nonPawnRow, file: .b)),
                Piece(type: .bishop, coordinates: Coordinates(rank: nonPawnRow, file: .c)),
                Piece(type: .queen, coordinates: Coordinates(rank: nonPawnRow, file: .d)),
                Piece(type: .king, coordinates: Coordinates(rank: nonPawnRow, file: .e)),
                Piece(type: .bishop, coordinates: Coordinates(rank: nonPawnRow, file: .f)),
                Piece(type: .knight, coordinates: Coordinates(rank: nonPawnRow, file: .g)),
                Piece(type: .rook, coordinates: Coordinates(rank: nonPawnRow, file: .h)),
                Piece(type: .pawn, coordinates: Coordinates(rank: pawnsRow, file: .a)),
                Piece(type: .pawn, coordinates: Coordinates(rank: pawnsRow, file: .b)),
                Piece(type: .pawn, coordinates: Coordinates(rank: pawnsRow, file: .c)),
                Piece(type: .pawn, coordinates: Coordinates(rank: pawnsRow, file: .d)),
                Piece(type: .pawn, coordinates: Coordinates(rank: pawnsRow, file: .e)),
                Piece(type: .pawn, coordinates: Coordinates(rank: pawnsRow, file: .f)),
                Piece(type: .pawn, coordinates: Coordinates(rank: pawnsRow, file: .g)),
                Piece(type: .pawn, coordinates: Coordinates(rank: pawnsRow, file: .h))]
    }
}
