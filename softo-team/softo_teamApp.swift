import SwiftUI

@main

struct softo_teamApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            
            //ProfileView()
            LogInView()
                .environmentObject(authViewModel)
        }
        
    }
    
}
