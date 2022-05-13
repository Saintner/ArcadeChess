//
//  ClinicRegistrationView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct ClinicRegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    private var isContinueEnabled: Bool {
        name.isEmpty || email.isEmpty || password.count < 8 || password.trimmingCharacters(in: .whitespaces).isEmpty
    }
    @ObservedObject var page = AppPage()
    
    var body: some View {
        VStack(alignment: .center){
            VStack{
                Image("signupbackground").backgroundImage(yOffset: 0, height: 400)
                Spacer()
            }
            VStack(alignment: .leading){
                Text("Signup").bold().foregroundColor(Color.mainBlue).font(.largeTitle).padding(.leading).offset(y: -50)
                    .padding(.bottom, -50)
                VStack(alignment: .center){
                    Spacer()
                    HStack{
                        Image("person.circle")
                        TextField("Clinic Name", text: $name)
                    }
                    .padding(.horizontal, 120.0)
                    HStack{
                        Image("envelope.circle")
                        TextField("Email", text: $email)
                    }
                    .padding(.horizontal, 120)
                    HStack{
                        Image("lock.circle")
                        TextField("Password",text: $password)
                    }
                    .padding(.horizontal, 120)
                }
                .padding(.bottom, 40.0)
            }
            VStack(alignment: .center){
                Spacer()
                NavigationLink(destination:  ClinicMoreInfoRegistrationView().setBackground(), tag: AppPageType.clinicMoreDetailRegistration,selection: $page.currentPage){ EmptyView() }
                .padding()
                Button {
                    self.page.currentPage = .clinicMoreDetailRegistration
                } label: {
                    Text("Continue").modifier(PrimaryFilledButton())
                }.disabled(isContinueEnabled)
            }
            .padding()
        }
    }
    
    
}

struct ClinicRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        ClinicRegistrationView()
    }
}

extension Image {
    func backgroundImage(yOffset: CGFloat, height: CGFloat = 600) -> some View{
        self.resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
            .aspectRatio(contentMode: .fill)
            .frame(width: 600.0, height: height)
            .offset(y: yOffset)
            .padding(.bottom, yOffset)
            .ignoresSafeArea(.all)
    }
}
