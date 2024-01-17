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
    @Environment(\.presentationMode) var presentationMode
    @State private var showingProfile = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen")
                .padding()
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showingProfile.toggle()
                    }) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 20, height: 20) // Adjust size as needed
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding()
                    }
                    .sheet(isPresented: $showingProfile, content: {
                        ProfileView() // Change this to your actual profile view
                    })

                    Button(action: {
                        showingSettings.toggle()
                    }) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 20, height: 20) // Adjust size as needed
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding()
                    }
                    .sheet(isPresented: $showingSettings, content: {
                        SettingsView()
                    })
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                if viewModel.isLoggedIn == false {
                    shouldNavigateToLogin = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}




struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
