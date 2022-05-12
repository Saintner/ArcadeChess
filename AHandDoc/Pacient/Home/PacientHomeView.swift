//
//  PacientHomeView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct PacientHomeView: View {
    var body: some View {
        VStack{
            Text("Hello, Pacient!")
        }.navigationBarBackButtonHidden(true)
    }
}

struct PacientHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PacientHomeView()
    }
}
