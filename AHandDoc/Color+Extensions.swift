//
//  Color+Extensions.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import Foundation
import SwiftUI

extension Color {
    public static var mainBlue: Color {
        return Color(UIColor(red: 0.38, green: 0.69, blue: 1.00, alpha: 1.00))
        }
    
    public static var secondaryBlue: Color {
        return Color(UIColor(red: 0.10, green: 0.17, blue: 0.76, alpha: 1.00))
        }
}


enum AppPageType {
    case initial
    case login
    case signup
}
