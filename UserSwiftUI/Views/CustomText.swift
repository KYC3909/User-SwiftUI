//
//  CustomText.swift
//  UserSwiftUI
//
//  Created by Krunal Chauhan on 20/10/23.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        
        // Custom Text commonly used
        Text(text)
            .lineLimit(1)
            .lineSpacing(24)
            .fontDesign(.rounded)
    }
}

#Preview {
    CustomText(text: "John Doe")
}
