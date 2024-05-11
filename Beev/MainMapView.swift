import SwiftUI
import MapKit
import CoreLocation

// ContentView
struct MainMapView: View {
    @State private var myPosition: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
    )
    
    @State private var mapCameraMode: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var style: MapStyle = .hybrid
    
    @State private var selectedMarker: Marker? = nil
    
    @State private var locationManager = CLLocationManager()
    
    @State private var isAdding = false
    
    var body: some View {
        ZStack {
            
            
            MapReader{ proxy in
                
                
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
                
                //LEGGE LE COORDINATE
            }.onTapGesture {position in //position è di tipo CGPOINT
                if isAdding{
                    print(position)
                    isAdding = false
                }
            }
            
            
            
            
            .mapStyle(style)
            .onAppear {
                setupMap()
            }
            
            
            
            
            
            
            
            .mapControls {
                MapPitchToggle() // Button to switch to 3D
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        selectedMarker = nil
                    }
            )
            
            
            
            
            // User location button
            ZStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        centerMapOnUserLocation()
                    }) {
                        Image(systemName: "location.fill")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    
                    //ADD
                    Button("ADD"){
                        
                        isAdding = true
                    }.background()
                    
                    
                    
                    
                }
            }
            
            
            
            
            // Card to display details of the selected marker
            if let marker = selectedMarker {
                VStack{
                    Spacer()
                    MarkerCardView(marker: marker)
                        .onTapGesture {
                            selectedMarker = nil
                        }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private func setupMap() {
        // Request location authorization
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Set the initial map region to the user's location
        LocationManagerDelegate().startUpdatingLocation(locationManager: locationManager, completion: { region in
            self.myPosition = region
        })
    }
    
    private func centerMapOnUserLocation() {
        if let userLocation = locationManager.location?.coordinate {
            myPosition = MKCoordinateRegion(
                center: userLocation,
                span: MKCoordinateSpan(latitudeDelta:180, longitudeDelta: 180)
            )
        }
    }
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.locationManager(manager, didUpdateRegion: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateRegion region: MKCoordinateRegion) {
        // Call the completion handler with the updated region
        if let completion = manager.delegate as? (MKCoordinateRegion) -> Void {
            completion(region)
        }
    }
    
    func startUpdatingLocation(locationManager: CLLocationManager, completion: @escaping (MKCoordinateRegion) -> Void) {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        // Set the initial map region to the user's location
        if let location = locationManager.location {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            completion(region)
        }
    }
}

//PREVIEW
struct MainMapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}
