//
//  AppTextField.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 28/07/2024.
//

import SwiftUI

struct AppTextFieldModel{
    @Binding var value : String
    let label : String
    let isPassword : Bool
    
    init(value: Binding<String>, label: String, isPassword: Bool = false) {
        self._value = value
        self.label = label
        self.isPassword = isPassword
    }
}

struct AppTextField: View {
    var prop : AppTextFieldModel
    @FocusState private var fieldIsFocused
    @State private var showPassword = false
    
    var body: some View {
        if(prop.isPassword == false){
            ZStack(alignment: .leading){
            
                HStack{
                    Text(prop.label)
                        .font(.sansRegular(size: 12))
                        .padding(.horizontal , 10)
                }
                .background(.white)
                .offset(y: fieldIsFocused || !prop.value.isEmpty ? -25 : 0)
                .animation(.easeInOut, value: fieldIsFocused == true)
                
                
                TextField("", text: prop.$value).focused($fieldIsFocused).textInputAutocapitalization(.never)
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
                    }
                    .background(.white)
                    .offset(y: fieldIsFocused || !prop.value.isEmpty ? -25 : 0)
                    .animation(.easeInOut, value:fieldIsFocused == true)
                    if(showPassword){
                        TextField("", text: prop.$value).focused($fieldIsFocused).textInputAutocapitalization(.never)
                    }else{
                        SecureField("", text: prop.$value ).focused($fieldIsFocused).textInputAutocapitalization(.never)
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
    VStack{
        AppTextField(prop: AppTextFieldModel(value: .constant(""), label: "label" , isPassword: false))
        TextField("" , text: .constant("ksk"))
//
//        AppTextField(prop: AppTextFieldModel(value: .constant(""), label: "label" , isPassword: true))
    }
}
