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
    var color: PieceColor
    var coordinates: Coordinates
    
    var movementsAllowed: [MovementType] {
        switch type {
        case .king, .queen:
            return [.diagonal, .horizontal, .vertical]
        case .bishop:
            return [.diagonal]
        case .knight:
            return [.l]
        case .rook:
            return [.horizontal, .vertical]
        case .pawn:
            return [.vertical]
        }
    }
    
    var distanceAllowed: DistanceType {
        switch type {
        case .king, .pawn:
            return .one
        case .queen, .bishop, .rook:
            return .noRestricted
        case .knight:
            return .three
        }
    }
    
    init(type initialType: PieceType, color: PieceColor, rank: Rank, file: File) {
        self.type = initialType
        self.color = color
        self.coordinates = Coordinates(rank: rank, file: file)
    }
    
    func isAllowedDistance(to destination: Coordinates) -> Bool {
        let fileDiff = abs(coordinates.file.rawValue - destination.file.rawValue)
        let rankDiff = abs(coordinates.rank.rawValue - destination.rank.rawValue)
        switch type {
        case .king:
            return rankDiff == 1 || fileDiff == 1
        case .queen:
            return true
        case .bishop:
            return rankDiff == fileDiff
        case .knight:
            return (fileDiff == 1 && rankDiff == 2) || (fileDiff == 2 && rankDiff == 1)
        case .rook:
            return true
        case .pawn:
            return rankDiff == 1 && fileDiff == 0
        }
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

extension Piece {
    
    static func initialPieces(for playerType: PieceColor) -> [Piece] {
        let nonPawnRank: Rank = playerType == .white ? .eight : .one
        let pawnRank: Rank = playerType == .white ? .seven : .two
        return [Piece(type: .rook, color: playerType, rank: nonPawnRank, file: .a),
                Piece(type: .knight, color: playerType, rank: nonPawnRank, file: .b),
                Piece(type: .bishop, color: playerType, rank: nonPawnRank, file: .c),
                Piece(type: .queen, color: playerType, rank: nonPawnRank, file: .d),
                Piece(type: .king, color: playerType, rank: nonPawnRank, file: .e),
                Piece(type: .bishop, color: playerType, rank: nonPawnRank, file: .f),
                Piece(type: .knight, color: playerType, rank: nonPawnRank, file: .g),
                Piece(type: .rook, color: playerType, rank: nonPawnRank, file: .h),
                Piece(type: .pawn, color: playerType, rank: pawnRank, file: .a),
                Piece(type: .pawn, color: playerType, rank: pawnRank, file: .b),
                Piece(type: .pawn, color: playerType, rank: pawnRank, file: .c),
                Piece(type: .pawn, color: playerType, rank: pawnRank, file: .d),
                Piece(type: .pawn, color: playerType, rank: pawnRank, file: .e),
                Piece(type: .pawn, color: playerType, rank: pawnRank, file: .f),
                Piece(type: .pawn, color: playerType, rank: pawnRank, file: .g),
                Piece(type: .pawn, color: playerType, rank: pawnRank, file: .h)]
    }
    
    
}
