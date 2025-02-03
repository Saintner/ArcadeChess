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
    
    init(type initialType: PieceType, rank: Rank, file: File) {
        self.type = initialType
        self.coordinates = Coordinates(rank: rank, file: file)
    }
    
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
            result =  (coordinates.file == destination.file && coordinates.rank != destination.rank) || (coordinates.file != destination.file && coordinates.rank == destination.rank)
        case .pawn:
            result = fileDiff == 0 && rankDiff == 1
        }
        return result
    }
    
    func involveCoordinates(with coordinates: Coordinates) -> [Coordinates] {
        let startPoint = self.coordinates
        let startRank = startPoint.rank.value
        let startFile = startPoint.file.value
        let endPoint = coordinates
        let endRank = endPoint.rank.value
        let endFile = endPoint.file.value
        let rankStep = (endRank - startRank == 0) ? 0 : (endRank > startRank ? 1 : -1)
        let fileStep = (endFile - startFile == 0) ? 0 : (endFile > startFile ? 1 : -1)
        var currentRank = startPoint.rank.value + rankStep
        var currentFile = startPoint.file.value + fileStep
        
        var involveCoordinates: [Coordinates] = []
        while currentRank != endPoint.rank.value || currentFile != endPoint.file.value {
            involveCoordinates.append(Coordinates(rank: currentRank, file: currentFile))
            currentFile += fileStep
            currentRank += rankStep
        }
        return involveCoordinates
    }
}

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
        let nonPawnRank: Rank = playerType == .white ? .eight : .one
        let pawnRank: Rank = playerType == .white ? .seven : .two
        return [Piece(type: .rook, rank: nonPawnRank, file: .a),
                Piece(type: .knight, rank: nonPawnRank, file: .b),
                Piece(type: .bishop, rank: nonPawnRank, file: .c),
                Piece(type: .queen, rank: nonPawnRank, file: .d),
                Piece(type: .king, rank: nonPawnRank, file: .e),
                Piece(type: .bishop, rank: nonPawnRank, file: .f),
                Piece(type: .knight, rank: nonPawnRank, file: .g),
                Piece(type: .rook, rank: nonPawnRank, file: .h),
                Piece(type: .pawn, rank: pawnRank, file: .a),
                Piece(type: .pawn, rank: pawnRank, file: .b),
                Piece(type: .pawn, rank: pawnRank, file: .c),
                Piece(type: .pawn, rank: pawnRank, file: .d),
                Piece(type: .pawn, rank: pawnRank, file: .e),
                Piece(type: .pawn, rank: pawnRank, file: .f),
                Piece(type: .pawn, rank: pawnRank, file: .g),
                Piece(type: .pawn, rank: pawnRank, file: .h)]
    }
}
