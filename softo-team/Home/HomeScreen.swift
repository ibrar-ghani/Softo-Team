//
//  HomeScreen.swift
//  SoftoFamily
//
//  Created by user on 02/01/2024.
//

import SwiftUI
import FirebaseAuth

struct HomeScreen: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @State private var showingSettings = false
    @State private var shouldNavigateToLogin = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen")
                    .padding()

                NavigationLink(
                    destination: SettingsView(),
                    isActive: $showingSettings,
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
                
                
//                NavigationLink(
//                    destination: LoginView(),
//                    isActive: $shouldNavigateToLogin,
//                    label: {
//                        EmptyView()
//                    }
//                )
//                .hidden()

                Button(action: {
                    showingSettings.toggle()
                }) {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .padding()
                }
                .sheet(isPresented: $showingSettings, content: {
                    SettingsView()
                })

                // ... (other UI components)
            }
            .padding()
            .onAppear {
                if viewModel.isLoggedIn == false {
                    shouldNavigateToLogin = true
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}




struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
