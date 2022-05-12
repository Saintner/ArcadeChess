//
//  SignupView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct SignupView: View {
    
    @ObservedObject var page = AppPage()
    var body: some View {
        VStack{
            Spacer()
            NavigationLink(destination:  ClinicRegistrationView().setBackground(), tag: AppPageType.clinicRegistration,selection: $page.currentPage){ EmptyView() }
            NavigationLink(destination:  PacientRegistrationView().setBackground(), tag: AppPageType.pacientRegistration
                           ,selection: $page.currentPage){ EmptyView() }
            NavigationLink(destination:  DoctorRegistrationView().setBackground(), tag: AppPageType.doctorRegistration,selection: $page.currentPage){ EmptyView() }
            Button {
                self.page.currentPage  = .clinicRegistration
            } label: {
                Text("I'm a clinic")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.appGrey)
            }
            Spacer()
            Button {
                self.page.currentPage  = .pacientRegistration
            } label: {
                Text("I'm a pacient")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.appGrey)
            }
            Spacer()
            Button {
                self.page.currentPage  = .doctorRegistration
            } label: {
                Text("I'm a Doctor")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.appGrey)
            }
            Spacer()
        }.navigationTitle("Sign up As")
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
