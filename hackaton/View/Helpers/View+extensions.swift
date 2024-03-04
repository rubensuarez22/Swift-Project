//
//  View+extensions.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 03/03/24.
//

import SwiftUI

extension View{
//    closing keyboards WHEN PRESSING signin or register button
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
//    Disabling with opacity
    
    func disableWithOpacity(_ condition: Bool)->some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    func hAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
//    Custm border view with padding
    func border(_ width: CGFloat, _ color: Color) ->some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .stroke(color, lineWidth: width)
            }
        
    }
//    Custom fill view with padding
    func fillView(_ color: Color) ->some View{
        self
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background{
                RoundedRectangle(cornerRadius: 5, style: .continuous)
                    .fill(color)
            }
        
    }
}
