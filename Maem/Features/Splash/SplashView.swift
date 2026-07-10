//
//  SplashView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 08/07/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            AppColor.red50
                .ignoresSafeArea()
            
            Image("AppLogo")
                .resizable()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    SplashView()
}
