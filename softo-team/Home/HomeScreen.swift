//
//  HomeScreen.swift
//  SoftoFamily
//
//  Created by user on 02/01/2024.
//

import SwiftUI
import FirebaseAuth

struct HomeScreen: View {
    @State private var isLogInActive = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen")
                    .padding()

                NavigationLink(destination: LogInView(), isActive: $isLogInActive) {
                    EmptyView()
                }
                .isDetailLink(false) // This avoids pushing a new view when the link is activated
                .navigationBarBackButtonHidden(true)

                Button("Sign Out") {
                    do {
                        try Auth.auth().signOut()
                        // Set the flag to navigate to the login screen
                        isLogInActive = true
                    } catch let error as NSError {
                        print("Error signing out: \(error.localizedDescription)")
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }.navigationBarBackButtonHidden(true)
    }
}



struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
