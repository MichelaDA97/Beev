import SwiftUI
import MapKit
import CoreLocation



// ContentView
struct MainMapView: View {
    
    @State private var myPosition: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 90),
        span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
    )
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)

    @State private var style: MKMapType = .hybridFlyover
    
    @State private var selectedMarker: Marker? = nil
    
    @State private var pos : MapCameraPosition = .userLocation(fallback: .automatic)
  /*
    
    func updateCameraPosition() {
        if let userLocation = locationManager.userLocation {
            let userRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.15,
                    longitudeDelta: 0.15
                )
            )
            withAnimation {
                cameraPosition = .region(userRegion)
            }
        }
    }*/
    
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $myPosition, showsUserLocation: true, userTrackingMode: .none, annotationItems: markers) { marker in
                MapAnnotation(coordinate: marker.coordinate) {
                    Image("f1")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .animation(.spring(response: 0.2, dampingFraction: 0.5)) // Animation
                        .onTapGesture {
                            selectedMarker = marker
                        }
                }
            }
            .onAppear {
                // Set the initial map region
                
               
                myPosition = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 40, longitude: -122),
                    span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
                )
                
                style = .hybridFlyover
                
                // Request location authorization
                CLLocationManager().requestWhenInUseAuthorization()
                
            
            }
            .mapControls {
                MapUserLocationButton() // Button to return to user's location
                MapPitchToggle() // Button to switch to 3D
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        selectedMarker = nil
                    }
            )
            
            // Card per visualizzare i dettagli del marker selezionato
            if let marker = selectedMarker {
                VStack{
                    Spacer()
                    MarkerCardView(marker: marker)
                        .onTapGesture {
                            selectedMarker = nil
                        }
                }
            }
        }.ignoresSafeArea()
    }
    
}

//PREVIEW
struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
       
    }
}





