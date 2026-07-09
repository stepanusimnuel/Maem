//
//  TenantInfoCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 09/07/26.
//

import SwiftUI

struct TenantInfoCard: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack(alignment: .top, spacing: 13) {
                Image("TenantLogo")
                    .frame(width: 94, height: 92)
                
                VStack(alignment: .leading, spacing: 9) {
                    Text("Ayam Bu Tini")
                        .font(AppFont.title2(weight: .bold))
                    
                    Text("Senin - Jumat (08.00 - 17.00)")
                        .font(AppFont.caption())
                        .foregroundStyle(AppColor.neutralDarkGrey)
                }
            }
            .frame(width: 370, height: 143)
            .background(AppColor.neutralWhite)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(
                color: Color.black, radius: 2, x: 0, y: 0
            )
            
            Divider()
            
            Divider()
            
            HStack(spacing: 13) {
                Image(systemName: "mappin.and.ellipse")
                    .font(AppFont.title2())
                    .padding(12)
                    .background(AppColor.neutralLightGrey)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack (alignment: .leading, spacing: 9) {
                    Text("ITC BSD")
                    Text("Foodcourt Lt.4")
                    Text("Sebelah kanan eskalator utama")
                        .foregroundStyle(AppColor.neutralDarkGrey)
                        .font(AppFont.caption())
                }
                .font(AppFont.body())
                
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    TenantInfoCard()
}
