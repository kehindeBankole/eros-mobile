//
//  AppTextField.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 28/07/2024.
//

import SwiftUI

struct AppTextFieldModel{
    var value : String
    let label : String
    let isPassword : Bool
    
    init(value: String, label: String, isPassword: Bool = false) {
        self.value = value
        self.label = label
        self.isPassword = isPassword
    }
}

struct AppTextField: View {
    @State var prop : AppTextFieldModel
    @FocusState private var fieldIsFocused: Bool
    @State private var showPassword = false
    
    var body: some View {
        if(prop.isPassword == false){
            ZStack(alignment: .leading){
                
                HStack{
                    Text(prop.label)
                        .font(.sansRegular(size: 12))
                        .padding(.horizontal , 10)
                }.background(.white).offset(y: fieldIsFocused == false && prop.value == "" ? 0 : -25).animation(.default, value: fieldIsFocused == true)
                
                
                TextField("", text: $prop.value).focused($fieldIsFocused).textInputAutocapitalization(.never)
            }   .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
                )
        }else{
            HStack(alignment: .top) {
                ZStack(alignment: .leading){
                    
                    HStack{
                        Text("Password")
                            .font(.sansRegular(size: 12))
                            .padding(.horizontal , 10)
                    }.background(.white).offset(y:fieldIsFocused == false && prop.value == "" ? 0 : -25).animation(.default, value:fieldIsFocused == true)
                    if(showPassword){
                        TextField("", text: $prop.value).focused($fieldIsFocused).textInputAutocapitalization(.never)
                    }else{
                        SecureField("", text: $prop.value ).focused($fieldIsFocused).textInputAutocapitalization(.never)
                    }
                }
                
                Button(action: {
                    
                    withAnimation(nil){
                        showPassword.toggle()
                    }
                    
                }, label: {
                    Image(systemName: showPassword ? "eye.circle" : "eye.slash")
                        .resizable()
                        .frame(width: 24, height: 24)
                })
            }.padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.9, green: 0.91, blue: 0.92), lineWidth: 1)
                )
        }
    }
}

#Preview {
    AppTextField(prop: AppTextFieldModel(value: "", label: "label" , isPassword: true))
}
