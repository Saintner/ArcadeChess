//
//  RegistrationSteps.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct RegistrationSteps: View {
    
    @State private var address = ""
    @State private var service = ""
    @ObservedObject var page = AppPage()
    
    var body: some View {
        VStack {
            Text("Address")
            TextField("Address", text: $address)
            Text("Services")
            TextField("Service", text:$service)
            NavigationLink(destination: ClinicHome().setBackground(), tag: AppPageType.clinicMainHome, selection: $page.currentPage) { EmptyView() }
            Button {
                self.page.currentPage = .clinicMainHome
            } label: {
                Text("Continue").font(.title2)
            }
        }.navigationTitle("Add more Info")
    }
}

struct RegistrationSteps_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationSteps()
    }
}
