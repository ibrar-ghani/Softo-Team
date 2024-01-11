//
//  ContentView.swift
//  SoftoFamily
//
//  Created by user on 21/12/2023.
//
import SwiftUI
import Firebase

struct LogInView: View {
    //    @EnvironmentObject private var viewModel: AuthViewModel
    @State var username: String = ""
    @State var password: String = ""
    @State private var isSignUpActive = false
    @State private var isSignUpCompleted = false
    @State private var isHomeScreenActive = false
    @State private var isOnboarding1Active = false
    @State private var showErrorAlert = false
    @State private var isSecure: Bool = true
    @State private var errorMessage = ""
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Section {
                        // Logo Section
                        Image(systemName: "person")
                            .font(.system(size: 80).bold())
                            .foregroundColor(.blue)
                    }
                    Text("Login to SoftoTeam")
                        .bold()
                        .padding(.vertical, 50)
                    
                    // username/email Section
                    Section {
                        VStack(alignment: .leading) {
                            Text("Username")
                                .padding(.leading, 20)
                            
                            TextField("Enter Your Email", text: $username)
                                .padding(.horizontal, 2)
                                .textFieldStyle(.roundedBorder)
                                .autocapitalization(.none)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(isValidEmail(email: username) ? Color.green : Color.red, lineWidth: 2)
                                )
                                .padding([.leading, .trailing], 20)
                                .frame(height: 40)
                                .frame(width: 350)
                            
                            Text("Password")
                                .padding(.leading, 20)
                            ZStack(alignment: .trailing) {
                                            if isSecure {
                                                SecureField("Enter Your Password", text: $password)
                                                    .padding(.horizontal, 10)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .autocapitalization(.none)
                                                    .disableAutocorrection(true)
                                            } else {
                                                TextField("Enter Your Password", text: $password)
                                                    .padding(.horizontal, 10)
                                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                                    .autocapitalization(.none)
                                                    .disableAutocorrection(true)
                                            }

                                            Button(action: {
                                                isSecure.toggle()
                                            }) {
                                                Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                                                    .foregroundColor(.gray)
                                                    .padding(.trailing, 10)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                        .padding()



                        }
                    }
                    .padding(.bottom, 30)
                    
                    NavigationLink(destination: HomeScreen(), isActive: $viewModel.isLoggedIn) {
                        EmptyView()
                    }
                    .isDetailLink(false)
                    .navigationBarBackButtonHidden(true)
                    
                    Button("Login") {
                        if username.isEmpty || password.isEmpty {
                            print("Please fill the required fields")
                        } else {
                            Auth.auth().signIn(withEmail: username, password: password) { _, error in
                                if let error = error {
                                    print("Error logging in: \(error.localizedDescription)")
                                    showErrorAlert = true
                                    errorMessage = "Invalid username or password"
                                } else {
                                    print("Login successful")
                                    viewModel.isLoggedIn = true
                                }
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .navigationBarBackButtonHidden(true)
                    .onAppear {
                        // Reset data when the view appears
                        username = ""
                        password = ""
                    }
                    
                    NavigationLink(destination: SignUpView(), isActive: $isSignUpActive) {
                        Text("Don't have an account?")
                            .foregroundColor(.red)
                            .underline()
                    }
                    .padding()
                    .navigationBarBackButtonHidden(true)
                }
            }
            .onAppear{
                viewModel.checkIfUserIsLoggedIn()
            }
        }
        .onChange(of: isSignUpActive) { newValue in
            // Reset the home screen activation when the user navigates to the sign-up screen
            if newValue {
                isHomeScreenActive = false
            }
        }
    }
    
    // Function to check the email format
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
