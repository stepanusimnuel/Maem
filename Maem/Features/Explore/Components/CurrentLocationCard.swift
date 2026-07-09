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

        Button {
            onLocationButtonTapped()
        } label: {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    
                    if selectedFoodCourt == nil {
                        Text("Pilih Food Court")
                            .font(AppFont.callout(weight: .regular))
                            
                    } else {
                        Text("\(selectedFoodCourt!.foodCourt.name),  \(selectedFoodCourt!.foodCourt.place)")
                            .font(AppFont.callout(weight: .bold))
                    }
                    
                }
                .foregroundStyle(AppColor.red700)

            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(AppColor.red100)
            .clipShape(
                Capsule()
            )
            .overlay(
                Capsule()
                    .stroke(AppColor.red700, lineWidth: 1)
            )
        }

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
