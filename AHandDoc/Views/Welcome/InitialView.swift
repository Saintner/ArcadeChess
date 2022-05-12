//
//  InitialView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

struct InitialView: View {
    @ObservedObject var page = AppPage()
    var body: some View {
        VStack{
            Text("Welcome")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            Spacer()
            VStack{
                Spacer()
                VStack {
                    NavigationLink(destination:  LoginView().setBackground(), tag: AppPageType.login,selection: $page.currentPage){ EmptyView() }
                    NavigationLink(destination:  SignupView().setBackground(), tag: AppPageType.signup,selection: $page.currentPage){ EmptyView() }
                    Button {
                        self.page.currentPage  = .login
                                           } label: {
                                               Text("Log in")
                                                   .font(.title2)
                                           }.padding(.bottom)
                    Button {
                        self.page.currentPage  = .signup
                    } label: {
                        Text("Sign Up")
                            .font(.title2)
                    }
                    .padding(.bottom)
                }
            }
            
        }.setBackground().navigationTitle("Home").navigationBarHidden(true)
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
