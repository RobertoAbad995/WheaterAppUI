//
//  LocationReady.swift
//  WheaterAppUI
//
//  Created by Consultant on 8/1/22.
//
import MapKit
import CoreLocation
import Foundation

protocol NewLocationReadyDelegate {
    
    var userLocation: CLLocationCoordinate2D? {get}
    var region : MKCoordinateRegion? {get}
    
    func reciveNewLocation(usrlocation: CLLocationCoordinate2D, userRegion: MKCoordinateRegion)
}
