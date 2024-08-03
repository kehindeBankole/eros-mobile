//
//  Home.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 20/07/2024.
//

import SwiftUI
import JWTDecode

struct Home: View {
var filters = ["All" , "buildings" , "estates"]
  @State var selectedFilter = "All"
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                HStack{
                    Spacer()
                    ZStack{
                        Circle()
                            .frame(width: 54)
                        if let userData = LocalStorage.decodeDataFromAppStorage(key: "userData", type: SignUpResponseData.self) {
                            Text("\(userData.user.firstName.first!)")
                                .textCase(.uppercase)
                                .foregroundStyle(.white)
                          
                        }
                       
                    }
  
                }.padding()
      
                    HStack{
                        if let userData = LocalStorage.decodeDataFromAppStorage(key: "userData", type: SignUpResponseData.self) {
                            VStack(alignment: .leading , spacing: 10){
                                Group{
                                    HStack{
                                        Text("Hey, ")
                                        Text(userData.user.firstName).font(.sansBold(size: 24)).foregroundStyle(.brown)
                                    }
                                    Text("Let's start exploring")
                                }.font(.system(size: 24))
                            }
                        }
                  
                        Spacer()
                    }.padding()
                
          
                    ScrollView(.horizontal , showsIndicators: false){
                        HStack{
                            ForEach(filters , id:\.self){ item in
                                let isActive = selectedFilter == item
                                Button(action: {
                                    withAnimation(nil){
                                        selectedFilter = item
                                    }
                                }){
                                    Text(item)
                                        .padding(20)
                                        .font(.sansMedium(size: 15))
                                        .foregroundStyle(isActive ? .white: .filterbuttontext)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(isActive ? .filterbuttontext : .filterbuttonbg)
                                            )
                                   
                                      
                                
                                }
                                .animation(.none, value: isActive)
                                .buttonStyle(PlainButtonStyle())
                         
                           
                            }
                        }
         
                    }.padding(.leading)
            }
        }
    }
}

#Preview {
    Home()
}
