//
//  BottomTab.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 16/07/2024.
//

import SwiftUI

enum Tab : String{
    case home = "home"
    case buildings = "building"
    case settings = "setting"
}

struct BottomTab: View {
    @State private var tabs : [(Tab, String)] = [(.home, "homeicon"), (.buildings, "hearticon"), (.settings, "profileicon")]
    @Binding var selectedTab : Tab
  @Namespace private var namespace
   
    var body: some View {
        HStack{

            ForEach(Array(tabs.enumerated()), id:\.1.0) {index, tab in
                Spacer()
                let isActive = selectedTab == tab.0
                VStack{
            
                    Button(action: {
                        print(tab)
                        withAnimation(.spring()) {
                            selectedTab = tab.0
                        }
                    }){
                        
                        VStack(spacing : 20){
                            Image(tab.1)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 25 , height: 25)
                                .foregroundStyle(.filterbuttontext)
                     
                            
                            if(isActive){
                                Circle()
                                    .fill(Color.filterbuttontext)
                                    .frame(width: 5, height: 5)
                                    .offset(y: -5)
                                    .matchedGeometryEffect(id: "activeIndicator", in: namespace)
                                    
                            }
                      
                        }
                    }
                  .buttonStyle(PlainButtonStyle())
                    
                }
                .padding(.vertical)
                Spacer()
            }
        }
        
    }
}

#Preview {
    BottomTab(selectedTab: .constant(.home))
}
