//
//  LocationManager.swift
//  Location Manager can controll the authorization, user location, and changes on the location services
//
//  Created by Consultant on 8/1/22.
//
import MapKit

//enum MapDetails{
//    static let startingLocation = CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708)
//    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//    static let defaultSpan2 = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//}

class LocationManager : NSObject, CLLocationManagerDelegate{
    
    private var locationManager : CLLocationManager!
    var userLocation: CLLocationCoordinate2D?
    var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    var delegate : NewLocationReadyDelegate!
    
    override init(){
        super.init()
        setLocation()
    }
    
    func setLocation(){
        //check if location services are enabled
        if CLLocationManager.locationServicesEnabled(){
            //then check permission status
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        else{
            print("Hey! I cant't get access to your location, go to settings first!")
            //Alert(title: Text("Warning"), message: Text("Location services are disabled, please enable first"), dismissButton: .cancel(Text("Ok")))
        }
    }
    
    func getUserLocation() -> CLLocationCoordinate2D?{
        return userLocation
    }
    
    func addUserLocation(map: MKMapView){
        
        //basic settings for map kit view
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.userLocation!
        map.addAnnotation(annotation)
        annotation.title = "Your are here!"
        annotation.subtitle = "Look for places nearby"
        map.showsUserLocation = true
        map.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            region = MKCoordinateRegion(center: self.userLocation!, span: MapDetails.defaultSpan)
            delegate.reciveNewLocation(usrlocation: self.userLocation!, userRegion: region)
        }
    }
    
    //When locationManager variable is initialized the class call the delegate to check authorization
    //also if the user change authorization outside the app, check at each change
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthStatus()
    }
    
    
    private func checkAuthStatus(){
        switch locationManager.authorizationStatus {
        case .restricted, .denied, .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            break
        }
    }
    
}
