//
//  SignUp.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 17/07/2024.
//

import SwiftUI

enum alertType {
    case error
    case success
}
struct SignUp: View {
    
    @State private var firstName = "kehinde"
    @FocusState private var firstNameFieldIsFocused: Bool
    @State private var lastName = "bankole"
    @FocusState private var lastNameFieldIsFocused: Bool
    @State private var email = "bankolek1@gmail.com"
    @FocusState private var emailFieldIsFocused: Bool
    @State private var showPassword = false
    @State private var password = "Ayinke2013#"
    @FocusState private var passFieldIsFocused: Bool
    @ObservedObject var authPath : AuthData
    @State private var isLoading = false
    let baseUrl = "http://localhost:5099/api/"
    @State private var alertMessage = ""
    @State private var showAlert = false
    @AppStorage("token") var token = ""
    
    func submitForm() async {
        
        do{
            isLoading = true
            let data : SignUpResponse? = try await makeApiCall(endpoint: baseUrl + "auth/register", method: .post , body: SignUpPayload(email: email, password: password ,firstName: firstName , lastName: lastName))
            authPath.authPath.removeLast()
            token = (data?.data.token)!
            
            alertMessage = "User created successfully"
            isLoading = false
            showAlert = true
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
        
        ScrollView(showsIndicators: false){
            VStack(spacing : 40){
                VStack(alignment: .leading , spacing: 11){
                    
                    Text("Join us").font(.sansMedium(size: 28))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .alert("\(alertMessage)", isPresented: $showAlert , actions: {
                    //
                })
                VStack(spacing : 20){
                    VStack(spacing: 20) {
                        
                        AppTextField(prop: AppTextFieldModel(value: firstName, label: "First Name"))
                        
                        AppTextField(prop: AppTextFieldModel(value:lastName, label: "Last Name"))
                        
                        AppTextField(prop: AppTextFieldModel(value: email, label: "Email address"))
                        
                        AppTextField(prop: AppTextFieldModel(value: password, label: "Password" , isPassword: true))
                        
                    }
                    
                    
                    // Sign up Button
                    Button(action: {
                        
                        Task(operation: {
                            await submitForm()
                        })
                        
                    }, label: {
                        isLoading ? AnyView(ProgressView()) : AnyView(Text("Sign up"))
                    })
                    .buttonStyle(CustomButtonStyle(type: .primary))
                    .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty)
                    
                }
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            
            Spacer()
        }
    }
}

#Preview {
    SignUp(authPath: AuthData())
}

