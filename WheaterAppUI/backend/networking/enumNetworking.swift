//
//  enumNetworking.swift
//  WheaterAppUI
//
//  Created by Consultant on 8/8/22.
//
import Foundation

enum NetworkError: Error{
    case urlFailure
    case badStatusCode
    case decodeFailure
    case other(Error)
}
