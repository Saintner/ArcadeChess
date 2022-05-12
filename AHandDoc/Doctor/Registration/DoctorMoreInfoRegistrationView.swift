//
//  DoctorMoreInfoRegistrationView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct DoctorMoreInfoRegistrationView: View {
    
    @State private var address = ""
    @State private var area = ""
    @ObservedObject var page = AppPage()
    
    var body: some View {
        VStack {
            Text("Address")
            TextField("Address", text: $address)
            Text("Area:")
            TextField("Area", text:$area)
            NavigationLink(destination: DoctorHome().setBackground(), tag: AppPageType.doctorMainHome, selection: $page.currentPage) { EmptyView() }
            Button {
                self.page.currentPage = .doctorMainHome
            } label: {
                Text("Continue").font(.title2)
            }
        }.navigationTitle("Add more Info")
    }
}

struct DoctorMoreInfoRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorMoreInfoRegistrationView()
    }
}
