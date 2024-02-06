//
//  ContentView.swift
//  SoftoFamily
//
//  Created by user on 21/12/2023.
//
import SwiftUI
import Firebase

struct LogInView: View {
    @State var username: String = ""
    @State var password: String = ""
    @AppStorage("accessToken")  var accessToken: String = ""
    @AppStorage("refreshToken")  var refreshToken: String = ""
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
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(isValidEmail(email: username) ? Color.green : Color.red, lineWidth: 2)
                                )
                                .padding()
                            
                            
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
                                    isHomeScreenActive = true
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
        } else {
            print("Login successful")
            
            // Fetch and store tokens
            fetchDataFromAPI()
        }
    }
    
    // function to fetch user personal details.
    func fetchPersonalDetails() {
        guard let personalInfoURL = URL(string: "https://api.staging.softoteam.com/api/v1/Users/\(viewModel.userId)") else {
            print("Invalid Personal Info API URL")
            return
        }
        
        var personalInfoRequest = URLRequest(url: personalInfoURL)
        personalInfoRequest.httpMethod = "GET"
        //    let authViewModel = AuthViewModel()
        personalInfoRequest.setValue("Bearer \(viewModel.accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: personalInfoRequest) { data, response, error in
            if let error = error {
                print("Error fetching personal details: \(error.localizedDescription)")
                return
            }
            
            // Check the status code
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            // Check data length
            print("Data Length: \(data?.count ?? 0)")
            
            // Print data directly as hexadecimal
            print("Response Data Hex: \(data! as NSData)")
            
            guard let data = data else {
                print("No data received for personal details")
                return
            }
            
            do {
                if let infoResponseModel = try? JSONDecoder().decode(PersonalInfoo.self, from: data) {
                    print("Decoded Model: \(infoResponseModel)")
                    // Update SwiftUI views on the main thread
                    DispatchQueue.main.async {
                        viewModel.setPersonalDetails(personalInfo: infoResponseModel)
                        print("Personal Info : \(String(describing: viewModel.setPersonalDetails(personalInfo: )))")
                        
                    }
                } else {
                    // Handle the case where decoding failed or infoResponseModel is nil
                    print("Error decoding personal info response or infoResponseModel is nil")
                    print("Response Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
                }
            }  catch let decodingError as DecodingError {
                // Handle specific decoding errors
                switch decodingError {
                case .dataCorrupted(let context):
                    print("Data Corrupted: \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                case .valueNotFound(let type, let context):
                    print("Value of type '\(type)' not found: \(context.debugDescription)")
                case .typeMismatch(let type, let context):
                    print("Type '\(type)' mismatch: \(context.debugDescription)")
                default:
                    print("Decoding error: \(decodingError.localizedDescription)")
                }
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
            } catch let error {
                // Handle other types of errors
                print("Error decoding personal info response: \(error)")
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
            }
            
        }.resume()
    }
    
    // function to fatch user id from the API
    
    func fetchUserIdFromAPI(completion: @escaping () -> Void) {
        guard let apiURL = URL(string: "https://api.staging.softoteam.com/api/v1/Auth/Info") else {
            print("Invalid API URL")
            return
        }
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET" // Assuming it's a POST request, update this based on your API
        
        // Set the Content-Type header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add your token and refresh token to the request headers
        request.setValue("Bearer \(viewModel.accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data from API: \(error.localizedDescription)")
                completion() // Call completion even in case of an error
                return
            }
            
            guard let data = data else {
                print("No data received from API")
                completion() // Call completion if there is no data
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(AuthInfoResponseModel.self, from: data)
                
                // Access the 'id' from the API response
                let userId = apiResponse.id
                viewModel.userId = userId
                print("User ID: \(userId)")
                print("viewModel.userId : \(viewModel.userId)")
                
                // Continue with the rest of your code
                completion() // Call completion once the data is successfully processed
            } catch {
                print("Error parsing API response: \(error.localizedDescription)")
                completion() // Call completion in case of an error during parsing
            }
        }.resume()
    }
    
    //Function to make a log IN request and get the tokens from the API
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
        request.setValue("Bearer \(viewModel.accessToken)", forHTTPHeaderField: "Authorization")
        
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
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(LogInResponseModel.self, from: data)
                
                // Store tokens in the AuthViewModel
                viewModel.setTokens(accessToken: apiResponse.token, refreshToken: apiResponse.refreshToken)
                // Fetch personal details using the obtained token
                fetchUserIdFromAPI{
                    fetchPersonalDetails()
                }
                
            } catch {
                print("Error parsing API response: \(error.localizedDescription)")
            }
        }.resume()
    }
}


struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
