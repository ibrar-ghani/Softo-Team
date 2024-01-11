import SwiftUI
import FirebaseCore
import FirebaseAuth
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

class AuthViewModel: ObservableObject {

    @Published var isLoggedIn: Bool = false


    // Check if user already loged in
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser != nil {
            self.isLoggedIn = true
        }
    }
    
    // Sign out user
    func signOut() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch let error as NSError {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    

    
}




@main

struct softo_teamApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
    
    
    
    var body: some Scene {
        WindowGroup {
            
            LogInView()
                .environmentObject(authViewModel)
            
        }
        
    }
        
}
