//
//  TenantInfoCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 09/07/26.
//

import SwiftUI

struct TenantInfoCard: View {
    // 1. Terima data Tenant nyata
    let tenant: Tenant

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center, spacing: 16) {
                if let imageName = tenant.imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    // Placeholder jika gambar tidak ada
                    Image(systemName: "storefront.fill")
                        .font(.largeTitle)
                        .foregroundColor(AppColor.neutralDarkGrey)
                        .frame(width: 80, height: 80)
                        .background(AppColor.neutralLightGrey)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(tenant.name)
                        .font(AppFont.title2(weight: .bold))
                        .foregroundStyle(AppColor.neutralBlack)
                    
                    Text(tenant.operationalHoursText)
                        .font(AppFont.caption())
                        .foregroundStyle(AppColor.neutralDarkGrey)
                }
                
                Spacer()
            }
            
            
            
            if let tenantImages = tenant.tenantImages {
                Divider()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(tenantImages, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 236, height: 177)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                }
                Divider()
            }
            
            HStack(spacing: 16) {
                Image(systemName: "mappin.and.ellipse")
                    .font(AppFont.title2())
                    .padding(12)
                    .background(AppColor.neutralLightGrey)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(AppColor.neutralBlack)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(tenant.foodCourt?.name ?? "Foodcourt")
                        .font(AppFont.body(weight: .semibold))
                    Text(tenant.foodCourt?.fcDescription ?? "Foodcourt Description")
                        .font(AppFont.body())
                    Text(tenant.detailLocation ?? "Tenant detail Location")
                        .foregroundStyle(AppColor.neutralDarkGrey)
                        .font(AppFont.caption())
                }
                
                Spacer()
            }
        }
        .padding(16)
        .background(AppColor.neutralWhite)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}

#Preview {
    TenantInfoCard(tenant: Tenant(name: "Test Tenant", imageName: "ayam-bu-tini", tenantImages: ["tenant-image-1", "tenant-image-2"], openDay: 1, closeDay: 6, openTime: "08.00", closeTime: "21.00", detailLocation:"Testing detail"))
}
