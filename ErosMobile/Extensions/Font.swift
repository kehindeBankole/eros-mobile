//
//  Font.swift
//  ErosMobile
//
//  Created by Kehinde Bankole on 13/07/2024.
//

import Foundation
import SwiftUI

extension Font {
    static func sansRegular(size:CGFloat = 16) -> Font {
        return .custom("DMSans18pt-Regular", size: size)
    }
    
    static func sansBold(size:CGFloat = 16) -> Font {
        return .custom("DMSans18pt-Bold", size: size)
    }
    
    static func sansMedium(size:CGFloat = 16) -> Font{
        return .custom("DMSans18pt-Medium", size:size)
    }
}
