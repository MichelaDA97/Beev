import SwiftUI
import MapKit
import CoreLocation


// ContentView
struct MainMapView: View {
    
    @State private var myPosition: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 90),
        span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
    )
    
    @State private var style: MKMapType = .hybridFlyover
    
    var body: some View {
        Map(coordinateRegion: $myPosition)
        
        
            .onAppear {
            
                
                // Set the initial map region
                myPosition = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 0, longitude: 90),
                    span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
                )
                // Request location authorization
                CLLocationManager().requestWhenInUseAuthorization()
                
                
            }
            .mapControls {
                MapUserLocationButton() // Button to return to user's location
                MapPitchToggle() // Button to switch to 3D
            }
        
    }
}






//PREVIEW
struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}







//PREVIEW
#Preview{
    MainMapView()
}
