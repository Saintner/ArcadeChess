//
//  Coordinates.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 3/02/25.
//

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
    
    func didMakeMovement(to coordinates: Coordinates) -> MovementType {
        let fileDiff = abs(self.file.rawValue - coordinates.file.rawValue)
        let rankDiff = abs(self.rank.rawValue - coordinates.rank.rawValue)
        if self.rank == coordinates.rank  && self.file != coordinates.file {
            return .horizontal
        } else if self.rank != coordinates.rank  && self.file == coordinates.file {
            return .vertical
        } else if self.rank != coordinates.rank && self.file != coordinates.file {
            if (fileDiff == 1 && rankDiff == 2) || (fileDiff == 2 && rankDiff == 1) {
                return .l
            } else {
                return .diagonal
            }
        } else {
            return .none
        }
    }
}
