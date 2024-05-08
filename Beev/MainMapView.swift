

import SwiftUI
import MapKit
import CoreLocation

// ContentView
struct MainMapView: View {
    
    
    @State private var myPosition: MapCameraPosition = .userLocation(fallback: .automatic)
   
    
    
    var body: some View {
        Map(position: $myPosition) {
            
        }.onAppear{CLLocationManager().requestWhenInUseAuthorization()} //POSIZIONE
            .mapControls{
                MapUserLocationButton() //BOTTONE PER TORNARE ALLA MIA POSIZIONE
                MapPitchToggle() //BOTTONE PER PASSARE AL 3D
            }
    }
}







//PREVIEW
#Preview{
    MainMapView()
}
