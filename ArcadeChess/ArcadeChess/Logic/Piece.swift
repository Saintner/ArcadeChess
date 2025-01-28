//
//  Piece.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 28/01/25.
//

protocol PieceProtocol: Hashable {}
struct Piece: PieceProtocol {
    var type: PieceType
    var position: Position
    
    func canMove(to destination: Position) -> Bool {
        var result = false
        result = self.position != destination
        let columnDiff = abs(position.column - destination.column)
        let rowDiff = abs(position.row - destination.row)
        switch type {
        case .king:
            result = columnDiff == 1 || rowDiff == 1
        case .queen:
            break
        case .bishop:
            result = position.column != destination.column && position.row != destination.row
            result = columnDiff == rowDiff
        case .knight:
            result = (columnDiff == 1 && rowDiff == 2) || (columnDiff == 2 && rowDiff == 1)
        case .rook:
            result = position.column != destination.column && position.row == destination.row
            result = position.column == destination.column && position.row != destination.row
        case .pawn:
            result = columnDiff == 0 && rowDiff == 1
        }
        return result
    }
}

extension Array where Element: PieceProtocol {
    func check() -> Bool {
        true
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
        let nonPawnRow = playerType == .white ? 8 : 1
        let pawnsRow = playerType == .white ? 7 : 2
        return [Piece(type: .rook, position: Position(row: nonPawnRow, column: 0)),
                Piece(type: .knight, position: Position(row: nonPawnRow, column: 1)),
                Piece(type: .bishop, position: Position(row: nonPawnRow, column: 2)),
                Piece(type: .queen, position: Position(row: nonPawnRow, column: 3)),
                Piece(type: .king, position: Position(row: nonPawnRow, column: 4)),
                Piece(type: .bishop, position: Position(row: nonPawnRow, column: 5)),
                Piece(type: .knight, position: Position(row: nonPawnRow, column: 6)),
                Piece(type: .rook, position: Position(row: nonPawnRow, column: 7)),
                Piece(type: .pawn, position: Position(row: pawnsRow, column: 0)),
                Piece(type: .pawn, position: Position(row: pawnsRow, column: 1)),
                Piece(type: .pawn, position: Position(row: pawnsRow, column: 2)),
                Piece(type: .pawn, position: Position(row: pawnsRow, column: 3)),
                Piece(type: .pawn, position: Position(row: pawnsRow, column: 4)),
                Piece(type: .pawn, position: Position(row: pawnsRow, column: 5)),
                Piece(type: .pawn, position: Position(row: pawnsRow, column: 6)),
                Piece(type: .pawn, position: Position(row: pawnsRow, column: 7))]
    }
}
