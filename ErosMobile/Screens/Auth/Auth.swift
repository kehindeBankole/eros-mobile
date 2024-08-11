//
//  Auth.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 16/07/2024.
//

import SwiftUI

struct Auth: View {

    @State private var email = ""
    @State private var password = ""
    @StateObject var authPath = AuthData()
    @State private var isLoading = false
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    func submitForm() async {
        do{
            isLoading = true
            let data : LoginResponse? = try await makeApiCall(endpoint: baseUrl + "auth/login", method: .post , body: LoginPayload(email: email, password: password))
            if(data != nil){
                LocalStorage.saveDataToAppStorage(data?.data , key: "userData")
            }
            
            authPath.authPath.append("layout")
            isLoading = false
            return
        }catch{
            isLoading = false
            
            switch(error) {
            case let MyError.badRequest(error):
                alertMessage = error
            default:
                alertMessage = error.localizedDescription
            }
            showAlert = true
        }
    }
    
    var body: some View {
        NavigationStack(path: $authPath.authPath){
            ScrollView(showsIndicators: false){
                VStack(spacing : 40){
                    VStack(alignment: .leading , spacing: 11){
                        Text("Welcome back").font(.sansMedium(size: 28))
                        Text("Let’s get you logged in to get back to managing your estate")
                    } .frame(maxWidth: .infinity, alignment: .leading)
                     
                    VStack(spacing : 20){

                        AppTextField(prop: AppTextFieldModel(value: $email, label: "Email address"))
                        
                        
                        AppTextField(prop: AppTextFieldModel(value: $password, label: "Password" , isPassword: true))
                        
                        Button(action: {
                            Task{
                                await submitForm()
                            }
                        }, label: {
                            isLoading ? AnyView(ProgressView()) : AnyView(Text("Sign in"))
                        }).buttonStyle(CustomButtonStyle(type: .primary)).disabled(email.isEmpty || password.isEmpty)
                        
                    }
                    Spacer()
                    
                    
                }.padding()
                    .navigationDestination(for: String.self){ item in
                        if(item == "signup"){
                            SignUp(authPath: authPath)
                        }
                        if(item == "layout"){
                            Layout()
                        }
                    }
            }
            
            Button(action: {
                authPath.authPath.append("signup")
            }, label: {
                Text("Don't have an account? Sign up")
            })
            .padding(.bottom)
            .alertSheet(isPresented: $showAlert , alertMessage: alertMessage , alertType: .error)
        }
    }
}

#Preview {
    Auth()
}
