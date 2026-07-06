//
//  CurrentLocationCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI
import CoreLocation

struct CurrentLocationCard: View {
    

    let selectedFoodCourt: FoodCourtDistance?
    let currentLocation: CLLocation?
    let authorizationStatus: CLAuthorizationStatus
    let onLocationButtonTapped: () -> Void

    @State private var searchText: String = ""
    
    var body: some View {

        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    if selectedFoodCourt == nil {
                        Text("Pilih Food Court")
                            .font(AppFont.callout(weight: .bold))
                    } else {
                        Text("\(selectedFoodCourt!.foodCourt.name),  \(selectedFoodCourt!.foodCourt.place)")
                            .font(AppFont.callout(weight: .bold))
                    }
                    
                }
                .foregroundStyle(AppColor.neutralBlack)
                
                Spacer()
                
                Button {
                    onLocationButtonTapped()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(AppFont.caption(weight: .bold))
                        .foregroundStyle(AppColor.red700)
                        .frame(width: 12, height: 12)
                }
                .buttonStyle(.glass)
                .clipShape(Circle())
                
            }
            
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")

                TextField("makanan untuk anak radang", text: $searchText)
                    .font(AppFont.callout(weight: .medium))
            }
            .font(AppFont.callout(weight: .medium))
            .padding(.horizontal, 10)
            .frame(height: 44)
            .glassEffect(in: .capsule)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 52)
        .padding(.bottom, 8)
        .clipShape(

            .rect(

                topLeadingRadius: 0,

                bottomLeadingRadius: 40,

                bottomTrailingRadius: 40,

                topTrailingRadius: 0

            )

        )

    }

}

#Preview {
    
    CurrentLocationCard(
        selectedFoodCourt: nil,
        currentLocation: nil,
        authorizationStatus: .notDetermined,
        onLocationButtonTapped: {}
    )
    .padding()

}
