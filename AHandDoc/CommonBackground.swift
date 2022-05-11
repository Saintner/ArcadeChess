//
//  CommonBackground.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import Foundation
import SwiftUI

struct BackgroundView<Content>: View where Content: View {
    
    var contentView: Content
    var body: some View {
            ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color.mainBlue,Color.white]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
                    contentView
            }
    }

    init( @ViewBuilder _ content: () -> Content) {
        self.contentView = content()
    }
}
