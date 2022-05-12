//
//  DoctorRegistrationView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct DoctorRegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var ocuppationNumber = ""
    @State private var password = ""
    @ObservedObject var page = AppPage()
    var body: some View {
        VStack(alignment: .center){
            VStack {
                Spacer()
                Text("Welcome")
                Spacer()
                TextField("Names", text: $name)
                    .padding(.horizontal, 120)
                Spacer()
                TextField("Email", text: $email)
                    .padding(.horizontal, 120)
                Spacer()
                TextField("Numero de colegio", text: $ocuppationNumber)
                    .padding(.horizontal, 120)
                Spacer()
                TextField("Password",text: $password)
                    .padding(.horizontal, 120)
            }
            VStack{
                NavigationLink(destination:  DoctorMoreInfoRegistrationView().setBackground(), tag: AppPageType.doctorMoreDetailRegistration,selection: $page.currentPage){ EmptyView() }
                Spacer()
                Button {
                    self.page.currentPage = .doctorMoreDetailRegistration
                    
                } label: {
                    Text("Continue").font(.title2)
                }.padding(.bottom)
            }
        }
    }
}

struct DoctorRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorRegistrationView()
    }
}
