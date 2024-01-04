//
//  HomeScreen.swift
//  SoftoFamily
//
//  Created by user on 02/01/2024.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        Text("Home Screen")
            .padding()
            .navigationBarTitle("Home Screen", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

