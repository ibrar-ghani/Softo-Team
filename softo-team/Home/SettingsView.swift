//
//  SettingsView.swift
//  softo-team
//
//  Created by user on 11/01/2024.
//
import SwiftUI
import Firebase

struct SettingsView: View {
//    @ObservedObject private var viewModel = AuthViewModel()
    @EnvironmentObject private var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingLogoutAlert = false

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()

            Button(action: {
                print("sign out tapped")
                showingLogoutAlert = true
//                viewModel.signOut()
//                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
            }
            .padding()
            .alert(isPresented: $showingLogoutAlert) {
                Alert(
                    title: Text("Are you sure you want to logout?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("Logout")) {
                        // Perform logout action
                        viewModel.signOut()
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
    }
}

