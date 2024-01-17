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
    var retryAttempts = 3
    @State private var isSignUpActive = false
    @State private var isSignUpCompleted = false
    @State private var isHomeScreenActive = false
    @State private var isOnboarding1Active = false
    @State private var showErrorAlert = false
    @State private var isSecure: Bool = true
    @State private var errorMessage = ""
    @State private var apiData: String = ""
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
                            
                            TextField("Enter Your Email/ User Name", text: $username)
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
                            // Determine whether the input is an email or a username
                            if isValidEmail(email: username) {
                                // Input is an email, attempt login with email
                                Auth.auth().signIn(withEmail: username, password: password) { _, error in
                                    handleLoginResult(error: error)
                                }
                            } else {
                                // Input is a username, implement your logic for username-based login
                                print("Perform username-based login logic here")
                                fetchDataFromAPI()
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
                    .alert(isPresented: $showErrorAlert) {
                        Alert(
                        title: Text("Invalid Credentials"),
                        message: Text("The provided username or password is incorrect. Please try again."),
                        dismissButton: .default(Text("OK"))
                        )
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
    
    // Function to handle login result
    func handleLoginResult(error: Error?) {
        if let error = error {
            print("Error logging in: \(error.localizedDescription)")
            showErrorAlert = true
            errorMessage = "Invalid username or password"
        } else {
            print("Login successful")
            viewModel.isLoggedIn = true
        }
    }
    
    func fetchDataFromAPI() {
        guard let apiURL = URL(string: "https://api.staging.softoteam.com/api/v1/Auth/Login") else {
            print("Invalid API URL")
            return
        }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST" // Assuming it's a POST request, update this based on your API
        
        // Set the Content-Type header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add your token and refresh token to the request headers
//        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIxIiwiUm9sZUlkIjoiMSIsIlVzZXJuYW1lIjoiZGV2IiwianRpIjoiODFmZjJmZjEtNDkyMi00Y2E3LWI1YzgtYjQ1OTQ4OGIyZWJkIiwiZXhwIjoxNzA1NjY2NTE1LCJpc3MiOiJzb2Z0b3NvbC5jb20iLCJhdWQiOiJzb2Z0b3NvbC5jb20ifQ.pXPapvODrI0A70yi6tz1IZKzMp0z_SuCBZobZsdNrLA"
//        let refreshToken = "7d1dfbda-0bf9-4311-8e2a-8eeb96df2a3a"
//
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        request.setValue(refreshToken, forHTTPHeaderField: "Refresh-Token")
        
        // Encode the request body if needed
        // Example: If your API expects a JSON body, encode the parameters and set the HTTPBody
        let requestBody: [String: Any] = ["username": username, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("Error encoding request body: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error fetching data from API: \(error.localizedDescription)")
                // Retry the request after a delay (adjust the delay as needed)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.fetchDataFromAPI()
                }
                return
            }
            
            guard let data = data else {
                print("No data received from API")
                return
            }
            
            // Print the raw data
            print("Raw API Response Data:")
            if let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
            }
            
            do {
                // Your existing code for parsing
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(LogInResponseModel.self, from: data)
                print("API Response Auth : \(apiResponse)")
                print("API Response Auth Token : \(apiResponse.token)")
                print("API Response Auth Refresh Token : \(apiResponse.refreshToken)")
                
                // Check if tokens are not nil or empty
                if !apiResponse.token.isEmpty && !apiResponse.refreshToken.isEmpty {
                // Set the isLoggedIn property to true
                self.viewModel.isLoggedIn = true
                }
            } catch {
                print("Error parsing API response: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}

struct LogInResponseModel: Decodable {
    // Define properties matching the structure of the API response
    // For example:
    let token: String
    let refreshToken: String
    // ... other properties
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
