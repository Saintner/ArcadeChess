//
//  PacientHomeView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct PacientHomeView: View {
    private var appoinments = 15
    var body: some View {
        VStack{
            List {
                        Text("doctor A")
                Text("doctor B")
                Text("doctor C")
                Text("doctor D")
                    }
        }.navigationBarBackButtonHidden(true)
    }
}

struct PacientHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PacientHomeView()
    }
}
