//
//  PointIterable.swift
//  ArcadeChess
//
//  Created by Eris Ramirez on 3/02/25.
//


protocol PointIterable: CaseIterable, Hashable, RawRepresentable {
    
}

extension PointIterable where RawValue == Int {
    init(value: Int) {
        self.init(rawValue: abs(value))!
    }
    
    var value: Int {
        return self.rawValue
    }
}
