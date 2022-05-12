//
//  PacientRegistrationView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct PacientRegistrationView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var page = AppPage()
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Text("Welcome")
            Spacer()
            TextField("Names", text: $name)
                .padding(.horizontal, 120)
            Spacer()
            TextField("Email", text: $email)
                .padding(.horizontal, 120)
            Spacer()
            TextField("Password",text: $password)
                .padding(.horizontal, 120)
            Spacer()
            VStack{
                NavigationLink(destination:  PacientHomeView().setBackground(), tag: AppPageType.pacientHome,selection: $page.currentPage){ EmptyView() }
                Spacer()
                Button {
                    self.page.currentPage = .pacientHome
                } label: {
                    Text("Continue").font(.title2)
                }.padding(.bottom)
            }
        }
    }
}

struct PacientRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        PacientRegistrationView()
    }
}
