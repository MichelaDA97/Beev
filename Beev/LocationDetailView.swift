import SwiftUI
import MapKit

struct LocationDetailView: View {
    var marker: Marker
    @State private var directions: [MKRoute.Step]?
    @State private var error: Error?
    @State private var routeShown = false
    
    var body: some View {
        VStack {
            if let directions = directions {
                VStack {
                    MapView(routeSteps: directions, destination: marker.coordinate)
                        .frame(height: 300)
                    List {
                        ForEach(directions, id: \.instructions) { step in
                            Text(step.instructions)
                        }
                    }
                }
            } else if let error = error {
                Text("Error: \(error.localizedDescription)")
            } else {
                ProgressView("Calculating directions...")
            }
        }
        .navigationTitle(marker.name)
        .onAppear {
            getDirections()
        }
    }
    
    func getDirections() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        let destinationPlacemark = MKPlacemark(coordinate: marker.coordinate)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                self.error = error
            } else if let response = response {
                self.directions = response.routes.first?.steps
                self.routeShown = true
            }
        }
    }
}

struct MapView: UIViewRepresentable {
    var routeSteps: [MKRoute.Step]
    var destination: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        mapView.showsUserLocation = true
        
        var coordinates = [CLLocationCoordinate2D]()
        for step in routeSteps {
            coordinates.append(step.polyline.coordinate)
        }
        let polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
        mapView.addOverlay(polyline)
        
        mapView.setRegion(MKCoordinateRegion(polyline.boundingMapRect), animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Nothing to update
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let polyline = overlay as? MKPolyline else {
                return MKOverlayRenderer()
            }
            
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            
            return renderer
        }
    }
}

#Preview("Location Detail View") {
    LocationDetailView(marker: Marker(name: "Elite Fitness Gym", coordinate: CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)))
}
