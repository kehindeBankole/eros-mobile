//
//  Layout.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 19/07/2024.
//

import SwiftUI

struct Layout: View {
    @State private var selectTab : Tab = .home
    
    var body: some View {
        VStack{
       
            TabView(selection: $selectTab){
                Home().tag(Tab.home)
                Settings().tag(Tab.settings)
            }
           Spacer()
            BottomTab(selectedTab: $selectTab)
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Layout()
}
