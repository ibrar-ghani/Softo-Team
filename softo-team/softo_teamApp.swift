import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        // Check the initial authentication status
        checkAuthenticationStatus()
    }

    func checkAuthenticationStatus() {
        if Auth.auth().currentUser != nil {
            // User is logged in
            isLoggedIn = true
        } else {
            // User is not logged in
            isLoggedIn = false
        }
    }
}

@main
struct softo_teamApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn {
                HomeScreen()
            } else {
                LogInView()
            }
        }
    }
}

    
