//
//  WeatherAppViewModel+APIRequest.swift
//  WheaterAppUI
//
//  Created by Consultant on 8/8/22.
//
import Combine
import Foundation

extension WeatherAppViewModel{
    
    
    
    internal func getWithCombine(){
        
        weatherMngr.getWithCombine(location: self.userLocation!)
            .receive(on: DispatchQueue.main)
            .sink{
                weather in
                switch (weather){
                    
                case .failure(let error):
                    print(error)
                    
                default:
                    break
                }
            } receiveValue: { [weak self] (weatherData: Weather) in
                self?.weather = weatherData
                self?.loading = false
            }
            .store(in: &self.subs)
    }
    
    internal func getWithURLsession(){
        weatherMngr.getWithURLsession(location: self.userLocation!){ result in
            switch(result){
            case .success(let data):
                DispatchQueue.main.async {
                    self.weather = data
                    self.loading = false
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    internal func getWithRxSwift(){
        
        
        
    }
    
    internal func getWithAlamoFire(){
        
        
        
        
    }
    
}
