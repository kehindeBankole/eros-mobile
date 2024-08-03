//
//  CustomButtonStyle.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 16/07/2024.
//

import SwiftUI

enum ButtonType{
    case primary , secondary
}

struct CustomButtonStyle: ButtonStyle {
    var type:ButtonType
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
               .frame(maxWidth: .infinity , maxHeight: 54)
               .frame(height: 60)
               .background(Rectangle().fill(type == .primary ? .red : .white)
                   .cornerRadius(5))
               .foregroundStyle(type == .primary ? Color.white : Color.red)
               .font(.sansBold(size: 15))
               .opacity(configuration.isPressed ? 0.5 : 1)

    }
    

}

