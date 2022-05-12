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
            NavigationLink(destination:  LoginView(), tag: AppPageType.login,selection: $page.currentPage){ EmptyView() }
            NavigationLink(destination:  SignupView(), tag: AppPageType.signup,selection: $page.currentPage){ EmptyView() }
            ZStack{
                VStack{
                    VStack{
                        Image("initialbackground")
                            .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .padding(.top, -75.0)
                            .frame(width: 600.0, height: 600.0)
                            .ignoresSafeArea()
                    }
                    Text("Welcome").font(.largeTitle).fontWeight(.medium).foregroundColor(Color.mainBlue).padding(.top, -550.0)
                    InitialButtonsBottomView(page: page)
                    Spacer()
                }
            }
            Spacer()
            
        }.navigationTitle("Home").navigationBarHidden(true)
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}



struct BaseButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 325.0, height: 65.0)
            .foregroundColor(.white)
            .font(.title2)
    }
}

struct FilledButton: ViewModifier {
    var color:  Color
    func body(content: Content) -> some View {
        content
            .modifier(BaseButton())
            .background(color)
            .cornerRadius(10)
    }
}

struct PrimaryFilledButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(FilledButton(color: Color.mainBlue))
    }
}

struct SecondaryFilledButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(FilledButton(color: Color.secondaryBlue))
    }
}

struct InitialButtonsBottomView : View {
    @ObservedObject var page = AppPage()
    var body: some View {
        VStack {
            
            VStack{
                Button {
                    self.page.currentPage  = .login
                } label: {
                    Text("Log in")
                        
                }
                .modifier(PrimaryFilledButton())
            }
            Spacer()
            VStack{
                Button {
                    self.page.currentPage  = .signup
                } label: {
                    Text("Sign Up")
                }
                .modifier(SecondaryFilledButton())
            }
        }
        .padding(.top, -75.0)
        .padding(.bottom, 20)
    }
}
