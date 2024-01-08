//
//  HomeScreen.swift
//  SoftoFamily
//
//  Created by user on 02/01/2024.
//

import SwiftUI
import FirebaseAuth

struct HomeScreen: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State var isLoggedIn: Bool = false

    var body: some View {
        VStack {
            Text("Home Screen")
                .padding()

            Button("Sign Out") {
                do {
                    try Auth.auth().signOut()
                    isLoggedIn = false
                } catch let error as NSError {
                    print("Error signing out: \(error.localizedDescription)")
                }
            }
        }
        .navigationBarTitle("Home Screen", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
