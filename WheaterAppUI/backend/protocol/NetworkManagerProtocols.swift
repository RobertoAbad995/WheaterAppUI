//
//  NetworkManager.swift
//  WheaterAppUI
//
//  Created by Consultant on 8/8/22.
//
import Combine
import Foundation

protocol NetworkManagerProtocols{
    
    func fetchAnyEntity<T: Decodable>(urlString: String) -> AnyPublisher<T,Error>
}

