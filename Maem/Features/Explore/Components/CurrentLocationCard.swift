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

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("Current Food Court")
                .font(.caption)
                .foregroundStyle(.secondary)

            if let selectedFoodCourt {

                Label(
                    selectedFoodCourt.foodCourt.name,
                    systemImage: "mappin.and.ellipse"
                )
                .font(.headline)

                Text(selectedFoodCourt.foodCourt.address)
                    .foregroundStyle(.secondary)

                Text(selectedFoodCourt.foodCourt.floor)
                    .foregroundStyle(.secondary)

                Label(
                    "\(Int(selectedFoodCourt.distance)) m away",
                    systemImage: "figure.walk"
                )
                .font(.caption)
                .foregroundStyle(.blue)

            } else {

                Label(
                    "Finding nearest food court...",
                    systemImage: "clock"
                )

            }

            Divider()

            Label(
                authorizationStatus == .authorizedAlways ||
                authorizationStatus == .authorizedWhenInUse
                    ? "Location Connected"
                    : "Location Not Available",
                systemImage: authorizationStatus == .authorizedAlways ||
                             authorizationStatus == .authorizedWhenInUse
                    ? "location.fill"
                    : "location.slash"
            )
            .font(.caption)
            .foregroundStyle(
                authorizationStatus == .authorizedAlways ||
                authorizationStatus == .authorizedWhenInUse
                ? .green
                : .orange
            )

            Text("Current Location")
                .font(.caption)
                .foregroundStyle(.secondary)

            switch authorizationStatus {

            case .authorizedAlways,
                 .authorizedWhenInUse:

                if let currentLocation {

                    Text("Latitude")
                        .font(.caption)

                    Text("\(currentLocation.coordinate.latitude)")

                    Text("Longitude")
                        .font(.caption)

                    Text("\(currentLocation.coordinate.longitude)")

                } else {

                    Text("Getting your location...")

                }

            case .denied,
                 .restricted:

                Text("Location permission denied.")

            case .notDetermined:

                Text("Requesting location permission...")

            @unknown default:

                Text("Unknown status.")

            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay {

            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray.opacity(0.2))

        }

    }

}

#Preview {

    CurrentLocationCard(
        selectedFoodCourt: nil,
        currentLocation: nil,
        authorizationStatus: .notDetermined
    )
    .padding()

}
