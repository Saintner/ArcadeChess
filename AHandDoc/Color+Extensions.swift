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
    
    public static var appGrey: Color {
        return Color(UIColor(red: 0.45, green: 0.43, blue: 0.46, alpha: 1.00))
    }
    
    public static var appBrown: Color {
        return Color(UIColor(red: 0.55, green: 0.28, blue: 0.26, alpha: 1.00))
    }
}


enum AppPageType: Any {
    case initial
    case login
    case signup
    case clinicRegistration
    case clinicMainHome
    case moreDetailClinicRegistration
    case pacientRegistration
    case doctorRegistration
}


