//
//  ContentView.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 13/07/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarded") var isOnboarded = false;
    var body: some View {
        VStack {
            isOnboarded ? AnyView(Auth()) : AnyView(Onboarding())
        }
    }
}

#Preview {
    ContentView()
}
