//
//  MapView.swift
//  WheaterAppUI
//
//  Created by Consultant on 8/1/22.
//
import MapKit
import SwiftUI

struct MapView: View {
    
    @ObservedObject private var vm = WeatherAppViewModel()

    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $vm.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(.pink)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
