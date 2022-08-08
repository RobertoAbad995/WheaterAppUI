//
//  MainTabView.swift
//  WheaterAppUI
//
//  Created by Consultant on 8/1/22.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView{
            
            MapView().tabItem{
                Image(systemName: "location")
                Text("Map")
            }
            
            WeatherView().tabItem{
                Image(systemName: "thermometer.sun.fill")
                Text("Weather")
            }
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}


