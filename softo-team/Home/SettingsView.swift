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
    //@Environment(\.presentationMode) var presentationMode
    @State private var shouldNavigateToLogin = false
    @State private var showingLogoutAlert = false
    @State private var shouldShowLoginSheet = false

    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()

            Button (action: {
                            print("sign out tapped")
                            showingLogoutAlert = true
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
                                    // Trigger navigation to login
                                    //coordinator.shouldNavigateToLogin = true
                                    shouldShowLoginSheet = true
                                }
                            )
                        }
                    }
                    .onAppear {
                        // Reset the coordinator when the view appears
                        //coordinator.shouldNavigateToLogin = false
                        shouldShowLoginSheet = false
                    }
                    .fullScreenCover(isPresented: $shouldShowLoginSheet) {
                                LogInView()
                            }
//                    .background(
//                        NavigationLink(destination: LogInView(), isActive: $coordinator.shouldNavigateToLogin) {
//                            EmptyView()
//                        }
//                        .navigationBarHidden(true)
//                    )
                }
}

class SettingsCoordinator: ObservableObject {
    @Published var shouldNavigateToLogin = false
}

