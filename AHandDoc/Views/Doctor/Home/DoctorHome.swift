//
//  DoctorHome.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct DoctorHome: View {
    var body: some View {
        VStack{
            Text("Hello, Home!")
        }.navigationBarBackButtonHidden(true).toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    print("pressed")
                }label: {
                    Text("Pacients").foregroundColor(Color.white)
                }
            }
        }
    }
}

struct DoctorHome_Previews: PreviewProvider {
    static var previews: some View {
        DoctorHome()
    }
}
