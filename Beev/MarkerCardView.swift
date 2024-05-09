//
//  MarkerCardView.swift
//  Beev
//
//  Created by Maria Concetta on 09/05/24.
//

import SwiftUI
import MapKit

// CardView per visualizzare i dettagli del marker
struct MarkerCardView: View {
    let marker: Marker
    @State private var address = "Loading..." // Placeholder for address
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(red: 46/255, green: 51/255, blue: 64/255))
            .frame(width: 350, height: 120)
            .overlay(
                VStack {
                
                    Text(address) // Display address here
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .font(.system(size: 20, weight: .light, design: .default)) // Set font to SF Compact
                }
            )
            .padding()
            .onAppear {
                // Perform reverse geocoding
                let location = CLLocation(latitude: marker.coordinate.latitude, longitude: marker.coordinate.longitude)
                CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                    if let error = error {
                        print("Reverse geocoding failed: \(error.localizedDescription)")
                        return
                    }
                    guard let placemark = placemarks?.first else {
                        print("No placemark found")
                        return
                    }
                    if let address = placemark.addressDictionary?["FormattedAddressLines"] as? [String], let firstLine = address.first {
                                         self.address = firstLine
                                     } else {
                                         self.address = "Address not found"
                                     }
                }
            }
    }
}


#Preview{
    MarkerCardView(marker: Marker(name: "Fountain 1", coordinate: CLLocationCoordinate2D(latitude: 45.123, longitude: 9.456)))
}

