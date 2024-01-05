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
    @State var firstname:String=""
    @State var lastname:String=""
    @State var username:String=""
    @State var password:String=""
    @State var conformpassword:String=""
    @State private var isLogInActive = false
    @State private var isOnboarding1Active = false
    
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
                Text("First Name")
                        .padding(.leading,20)
                 TextField("Enter Your First Name",text: $firstname)
                        .padding(.horizontal,20)
                        .textFieldStyle(.roundedBorder)
                
                    Text("Last Name")
                    .padding(.leading,20)
                TextField("Enter Your Last Name",text: $lastname)
                .padding(.horizontal,20)
                .textFieldStyle(.roundedBorder)
                
                Text("Email")
                .padding(.leading,20)
                TextField("Enter Your Email",text: $username)
                .padding(.horizontal,20)
                .textFieldStyle(.roundedBorder)
                
                Text("Password")
                        .padding(.leading,20)
                TextField("Create A Strong Password",text:$password)
                .padding(.horizontal,20)
                .textFieldStyle(.roundedBorder)
                
                
                Text("Conform Password")
                    .padding(.leading,20)
                TextField("Enter Same Password",text: $conformpassword)
                    .padding(.horizontal,20)
                    .textFieldStyle(.roundedBorder)
                }
            }
            .padding(.bottom,50)
            Button("Create", action: {
                if username == "" || password == "" || firstname=="" || lastname==""{
                    print("Please fill the required fields")
                }
                else{
                    Auth.auth().createUser(withEmail: username, password: password)
                    {
                        authResult, error in
                        if let error = error{
                    print("error creating user: \(error.localizedDescription)")
                        }
                else if let authResult = authResult {
                let userProfile = UserProfile(uid: authResult.user.uid, email: username, firstName: firstname, lastName: lastname)
                saveUserProfileToFirestore(userProfile)
                print("User created successfully")
                            isOnboarding1Active = true
                        }
                    }
                }
            })
            .buttonStyle(.borderedProminent)
            .navigationBarBackButtonHidden(true)
        NavigationLink(
            destination: Onboarding1(),
            isActive: $isOnboarding1Active,
            label: {
            EmptyView() // Use EmptyView to create a hidden navigation link label
                            })
            NavigationLink(destination: LogInView(), isActive: $isLogInActive){
                            Text("Already have an account?")
                                .foregroundColor(.red)
                                .underline()
                        }
                        .padding()
                        .navigationBarBackButtonHidden(true)
        }
    }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
