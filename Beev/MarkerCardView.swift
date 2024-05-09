import SwiftUI
import MapKit

// CardView per visualizzare i dettagli del marker
struct MarkerCardView: View {
    let marker: Marker
    @State private var address = "Loading..." // Placeholder for address
    @State private var showingLocationDetail = false
    
    var body: some View {
        
        
        ZStack{
            if showingLocationDetail {
                LocationDetailView(marker: marker)
            } else{
                
                
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 46/255, green: 51/255, blue: 64/255))
                    .frame(width: 350, height: 120)
                    .overlay(
                        VStack {
                            HStack {
                                Text(address) // Display address here
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                    .font(.system(size: 18, weight: .light, design: .default)) // Set font to SF Compact
                                Spacer()
                                Button(action: {
                                    showingLocationDetail = true
                                    LocationDetailView(marker: marker)
                                    
                                }) {
                                    Image(systemName: "arrow.right.circle.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 25, weight: .light, design: .default))
                                }
                            }
                        }
                            .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                    )
                    .padding()
                /*   .sheet(isPresented: $showingLocationDetail) {
                 LocationDetailView(marker: marker)
                 }*/ }}
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
