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
            ZStack{
                Image("initialbackground").backgroundImage(yOffset: -75)
                Text("Welcome").font(.largeTitle).fontWeight(.medium).foregroundColor(Color.mainBlue)
                    .offset(y: -20)
                    .padding(.bottom, -20)
            }
            VStack{
                Spacer()
                NavigationLink(destination:  LoginView(), tag: AppPageType.login,selection: $page.currentPage){ EmptyView() }
                NavigationLink(destination:  SignupView(), tag: AppPageType.signup,selection: $page.currentPage){ EmptyView() }
                InitialButtonsBottomView(page: page)
                    .offset(y: -40)
                    .padding(.bottom, 40.0)
            Spacer()
            }.navigationTitle("").navigationBarHidden(true)
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}



struct BaseButton: ViewModifier {
    @Environment(\.isEnabled) var isEnabled
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 325.0, height: 65.0)
            .foregroundColor(isEnabled ? .white : .gray)
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
    @Environment(\.isEnabled) var isEnabled
    func body(content: Content) -> some View {
        content
            .modifier(FilledButton(color: isEnabled ? Color.mainBlue : Color.appGrey))
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
                Button {
                    self.page.currentPage  = .login
                } label: {
                    Text("Log in")
                        .modifier(PrimaryFilledButton())
                        
                }
                .padding(.bottom)
                Button {
                    self.page.currentPage  = .signup
                } label: {
                    Text("Sign Up")
                        .modifier(SecondaryFilledButton())
                }
    }
}
