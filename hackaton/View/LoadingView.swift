//
//  LoadingView.swift
//  hackaton
//
//  Created by José Ángel del Monte Salazar on 03/03/24.
//

import SwiftUI

struct LoadingView: View {
    @Binding var show: Bool
    var body: some View {
        ZStack{
            if show {
                Group{
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(.white,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }.animation(.easeInOut(duration: 0.25), value: show)
    }
}


