//
//  FindFoodcourtAnimation.swift
//  Maem
//
//  Created by Stepanus Imanuel on 08/07/26.
//

import SwiftUI

struct FindFoodcourtAnimation: View {
    @State private var pulse1: Bool = false
    @State private var pulse2: Bool = false
    @State private var pulse3: Bool = false
    var body: some View {
        ZStack {
            AppColor.red50.ignoresSafeArea()
            
            VStack(spacing: 48) {
                Text("Mencari Foodcourt Terdekat")
                    .font(AppFont.headline())
                
                ZStack {
                    Circle()
                        .stroke(AppColor.red700, lineWidth: 1)
                        .frame(width: 275, height: 275)
                        .overlay(
                            Image("Pin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 42.5)
                                .offset(x: -125, y: 150)
                                , alignment: .top
                        )
                        .scaleEffect(pulse3 ? 1.2 : 0.8)
                        .opacity(pulse3 ? 1 : 0)
                    
                    Circle()
                        .stroke(AppColor.red700, lineWidth: 1)
                        .frame(width: 220, height: 220)
                        .overlay(
                            Image("Pin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 34, height: 42.5)
                                .offset(x: 75, y: -10)
                                , alignment: .top
                        )
                        .scaleEffect(pulse2 ? 1.2 : 0.8)
                        .opacity(pulse2 ? 1 : 0)
                    
                    Circle()
                        .stroke(AppColor.red700, lineWidth: 1)
                        .frame(width: 154, height: 154)
                        .scaleEffect(pulse1 ? 1.2 : 0.8)
                        .opacity(pulse1 ? 1 : 0)
                    
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 68, height: 68)
                }
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    func startAnimation() {
        withAnimation(.easeInOut(duration: 0.5)) {
            pulse1.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeInOut(duration: 0.5)) {
                pulse2.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation(.easeInOut(duration: 0.5)) {
                pulse3.toggle()
            }
        }
    }
}

#Preview {
    FindFoodcourtAnimation()
}
