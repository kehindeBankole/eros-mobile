//
//  AlerView.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 11/08/2024.
//

import SwiftUI

enum AlertType{
    case error
    case success
}

struct AlerView: View {
    @State var alertMessage : String
    @State var alertType : AlertType
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "house")
                .frame(width: 65, height: 65)
                .background(.red.gradient, in: .circle)
                .background {
                    Circle()
                        .stroke(.background, lineWidth: 8)
                }
            
            Text(alertType == .error ? "Something went wrong" : "Successful operation")
                .font(.sansBold(size: 24))
            Text(alertMessage)
                .font(.sansMedium())
        }
        .padding([.horizontal, .bottom], 15)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
                .padding(.top, 30)
        
        }
        .padding()
        .shadow(color: .black.opacity(0.12), radius: 8)
        .presentationDetents([.medium])
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline:.now() + 2){
                withAnimation{
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AlerView(alertMessage: "hello", alertType: .error)
}
