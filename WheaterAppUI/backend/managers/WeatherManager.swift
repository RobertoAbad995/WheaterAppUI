//
//  WeatherManager.swift
//  WheaterAppUI
//
//  Created by Consultant on 8/2/22.
//

import CoreLocation
import Foundation
import Combine

final class WeatherManager{
    
    private var location : CLLocationCoordinate2D!
    private var weather : Weather?
    
    internal func getWithCombine<T>(location: CLLocationCoordinate2D) -> AnyPublisher<T, NetworkError> where T : Decodable {
        
        self.location = location
        
        guard let url = URL(string: getURL()) else {
            return Fail(error: NetworkError.urlFailure).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { map in
                
                if let hResponse = map.response as? HTTPURLResponse,
                   !(200..<300).contains(hResponse.statusCode) {
                    
                    throw NetworkError.badStatusCode
                }
                return map.data
            }.decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return NetworkError.other(error)
            }.eraseToAnyPublisher()
        
    }
    
    private func getWithRxSwift(){
        
    }
    
    private func getWithAlamoFire(){
        
//        Ala
        
    }
    
    func getWithURLsession(location: CLLocationCoordinate2D, completion: @escaping (Result<Weather,Error>)->()){
        self.location = location
        URLSession.shared.getRequest(url: URL(string: getURL()), decoding: Weather.self, completion: completion)
        
    }
    private func getURL() -> String{
        return "https://weatherdbi.herokuapp.com/data/weather/\(self.location.latitude),\(self.location.longitude)"
    }
}

enum SourceWith{
    case AlamoFire
    case Combine
    case URLSession
    case RxSwift
}
