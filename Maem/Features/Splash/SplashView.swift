//
//  SplashView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 08/07/26.
//

enum AppPhase {
    case splash
    case locating
    case explore
}

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            AppColor.red700
                .ignoresSafeArea()
            
            VStack {
                Image("AppLogo")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("Maem")
                    .font(AppFont.largeTitle(weight: .bold))
                    .foregroundStyle(AppColor.neutralWhite)
            }
        }
    }
}

#Preview {
    SplashView()
}
