//
//  ContentView.swift
//  SoftoFamily
//
//  Created by user on 21/12/2023.
//
import SwiftUI
import Firebase

struct LogInView: View {
    @State var username:String = ""
    @State var password:String = ""
    @State private var isSignUpActive = false
    @State private var isHomeScreenActive = false
    @State private var showErrorAlert = false
    @State private var errorMessage=""
    
    var body: some View {
        NavigationView{
        VStack{
            Section{
                // Logo Section
                
                Image(systemName: "person")
                    .font(.system(size: 80).bold())
                    .foregroundColor(.blue)
            }
            Text("Login to SoftoTeam")
                .bold()
                .padding(.vertical,50)
            
            // username/email Section
            Section{
                
                VStack(alignment: .leading){
                    Text("Username")
                        .padding(.leading,20)
                    TextField("Enter Your Email",text: $username)
                        .padding(.horizontal,20)
                        .textFieldStyle(.roundedBorder)
                    Text("Password")
                        .padding(.leading,20)
                    TextField("Enter Your Password",text: $password)
                        .padding(.horizontal,20)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding(.bottom,50)
            Button("Login", action: {
                if username == "" || password == ""{
                    print("Please fill the required fields")
                }else{
                    Auth.auth().signIn(withEmail: username, password: password)
                    {
                    authResult, error in
                        if let error = error{
                print("error logging in \(error.localizedDescription)")
                showErrorAlert = true
            errorMessage = "Invalid username or password"
                        }else{
                    print("log in sucessful:")
                    isHomeScreenActive=true
                        }
                    }
                }
            })
            .buttonStyle(.borderedProminent)
            .navigationBarBackButtonHidden(true) // Hide back button
            NavigationLink(
                destination: HomeScreen(),
                isActive: $isHomeScreenActive,
                label: {
                EmptyView() // Use EmptyView to create a hidden navigation link label
                                })
            
            
        NavigationLink(destination: SignUpView(), isActive: $isSignUpActive){
                            Text("Don't have an account?")
                                .foregroundColor(.red)
                                .underline()
                        }
                        .padding()
                        .navigationBarBackButtonHidden(true) // Hide back button
        }
        }
    .navigationViewStyle(StackNavigationViewStyle())
        
    }
}


struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
