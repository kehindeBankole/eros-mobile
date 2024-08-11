//
//  View.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 10/08/2024.
//

import Foundation
import SwiftUI

extension View{
    
    func alertSheet(isPresented:Binding<Bool> ,alertMessage:String , alertType:AlertType ) -> some View{
        
        self.sheet(isPresented: isPresented){
          AlerView(alertMessage: alertMessage, alertType: alertType)
                .presentationCornerRadius(0)
                .presentationBackground(.clear)
                .presentationDragIndicator(.hidden)
        }
        
        
    }
}
