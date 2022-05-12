//
//  ClinicHome.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct ClinicHome: View {
    var body: some View {
        VStack{
            Text("Hello, Home!")
        }.navigationBarBackButtonHidden(true).toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button{
                    print("pressed")
                }label: {
                    Text("Customers").foregroundColor(Color.white)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    print("pressed")
                }label: {
                    Text("Doctors").foregroundColor(Color.white)
                }
            }
        }
    }
}

struct ClinicHome_Previews: PreviewProvider {
    static var previews: some View {
        ClinicHome()
    }
}
