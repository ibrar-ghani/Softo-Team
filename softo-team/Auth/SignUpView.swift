//
//  SignUpView.swift
//  SoftoFamily
//
//  Created by user on 02/01/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct UserProfile {
    let uid: String
    let email: String
    let firstName: String
    let lastName: String
}

struct SignUpView: View{
    @State var password:String=""
    @State var conformpassword:String=""
    @State private var isLogInActive = false
    @State private var isTabViewActive = false
    @State private var selectedTab: Int = 0
    @State private var isSecure: Bool = true
    @AppStorage("firstname") private var firstname: String = ""
    @AppStorage("lastname") private var lastname: String = ""
    @AppStorage("username") private var username: String = ""
    
    
    var body: some View{
        ScrollView{
            VStack{
                Section{
                    //logo section
                    Image(systemName: "person")
                        .font(.system(size: 80).bold())
                        .foregroundColor(.blue)
                }
                Text("Create Account On SoftoTeam")
                    .bold()
                    .padding(.vertical,50)
                
                //user details section
                Section{
                    VStack(alignment: .leading){
                        //First Name
                        //{
                        Text("First Name")
                            .padding(.leading,20)
                        TextField("Enter Your First Name",text: $firstname)
                            .padding(.horizontal,20)
                            .textFieldStyle(.roundedBorder)
                        //}
                        
                        //Last Name
                        //{
                        Text("Last Name")
                            .padding(.leading,20)
                        TextField("Enter Your Last Name",text: $lastname)
                            .padding(.horizontal,20)
                            .textFieldStyle(.roundedBorder)
                        //}
                        
                        
                        // Email
                        Text("Email")
                            .padding(.leading, 20)
                        TextField("Enter Your Email", text: $username)
                            .padding(.horizontal, 2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(isValidEmail(email: username) ? Color.green : Color.red, lineWidth: 2)
                            )
                            .padding()
                        
                        
                        // Password
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
                        // Confirm Password
                        Text("Confirm Password")
                            .padding(.leading,20)
                        ZStack(alignment: .trailing) {
                            if isSecure {
                                SecureField("Enter Same Password", text: $conformpassword)
                                    .padding(.horizontal, 2)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(conformpassword == password ? Color.green : Color.red, lineWidth: 2)
                                    )
                            } else {
                                TextField("Enter Same Password", text: $conformpassword)
                                    .padding(.horizontal, 2)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(conformpassword == password ? Color.green : Color.red, lineWidth: 2)
                                    )
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
                        .padding([.leading, .trailing], 10)
                        .onChange(of: conformpassword) { newValue in
                            // Check if the conform password matches the password
                            print("Passwords Match")
                            if newValue != password {
                                // You can show an error message or handle it accordingly
                                // For now, let's print a message
                                print("Passwords do not match!")
                            }
                        }
                    }
                }
                .padding(.bottom,30)
                
                NavigationLink(destination: MyTabView(), isActive: $isTabViewActive) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
                Button("Create", action: {
                    if username == "" || password == "" || firstname=="" || lastname=="" {
                        print("Please fill the required fields")
                    } else {
                        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                            if let error = error {
                                print("error creating user: \(error.localizedDescription)")
                            } else if let authResult = authResult {
                                let userProfile = UserProfile(uid: authResult.user.uid, email: username, firstName: firstname, lastName: lastname)
                                saveUserProfileToFirestore(userProfile)
                                print("User created successfully")
                                
                                isTabViewActive = true
                            }
                        }
                    }
                })
                .buttonStyle(.borderedProminent)
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    // Reset data when the view appears
                    firstname=""
                    lastname=""
                    username = ""
                    password = ""
                    conformpassword=""
                }
                NavigationLink(destination: LogInView(), isActive: $isLogInActive){
                    Text("Already have an account?")
                        .foregroundColor(.red)
                        .underline()
                }
                .padding()
                .navigationBarBackButtonHidden(true)
            }.navigationBarBackButtonHidden(true)
        }
        
    }
}

// Function to check the email format
func isValidEmail(email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
}

func saveUserProfileToFirestore(_ userProfile: UserProfile) {
    let db = Firestore.firestore()
    
    // Use the 'users' collection in Firestore
    db.collection("users").document(userProfile.uid).setData([
        "email": userProfile.email,
        "firstName": userProfile.firstName,
        "lastName": userProfile.lastName
    ]) { error in
        if let error = error {
            print("Error saving user profile: \(error.localizedDescription)")
        } else {
            print("User profile saved successfully to Firestore")
        }
    }
}

