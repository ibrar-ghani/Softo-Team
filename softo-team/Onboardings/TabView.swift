//
//  TabView.swift
//  softo-team
//
//  Created by user on 11/01/2024.
//

import SwiftUI

struct MyTabView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            Onboarding1(selectedTab: $selectedTab)
                .tag(0)
                
            Onboarding2(selectedTab: $selectedTab)
                .tag(1)

            Onboarding3(selectedTab: $selectedTab)
                .tag(2)
                
            Onboarding4(selectedTab: $selectedTab)
                .tag(3)
            HomeScreen()
                .tag(4)
        }
    }
}

//struct MyTabView_Previews: PreviewProvider {
//    @State private var selectedTab: Int = 0
//    static var previews: some View {
//        MyTabView(selectedTab: $selectedTab)
//    }
//}


