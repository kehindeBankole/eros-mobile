//
//  Onboarding.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 13/07/2024.
//

import SwiftUI

let onboardContent = [OnboardingModel(title: "Title 1", subtitle: "Subtitle 1") , OnboardingModel(title: "Title 2", subtitle: "Subtitle 2") , OnboardingModel(title: "Title 3", subtitle: "Subtitle 3")]


struct Onboarding: View {
    @State var currentView = onboardContent[0]
    @State private var currentIndex = 0
    @AppStorage("isOnboarded") var isOnboarded = false;
    var body: some View {
        VStack{
            TabView(selection:$currentView){
                ForEach(onboardContent, id:\.self, content: { item in
                    VStack(){
                        HStack{
                            VStack(alignment: .leading , spacing: 8){
                                Text(item.title).font(.sansBold(size: 28))
                                Text(item.subtitle).font(.system(size: 18))
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding()
                    .tag(item)
                })
            }.tabViewStyle(PageTabViewStyle())
            Button(action: {
                isOnboarded = true
            }, label: {
                Text("GET STARTED").font(.sansBold())
            }).buttonStyle(CustomButtonStyle(type:.primary))
        }
        .edgesIgnoringSafeArea(.all).id(currentIndex)
    }
}

#Preview {
    Onboarding()
}
