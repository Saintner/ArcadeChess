//
//  ParentView.swift
//  AHandDoc
//
//  Created by Eris Martinez on 5/11/22.
//

import SwiftUI

final class AppPage: ObservableObject {
    @Published var currentPage: AppPageType? = .initial
}

extension View {
    func setBackground() -> some View {
        return BackgroundView{
            self
        }
    }
}

struct ParentView: View {
    var body: some View {
        NavigationView {
            InitialView().setBackground()
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
