//
//  Endpoint.swift
//  MovieAppExample
//
//  Created by Ensar on 19.06.2023.
//

import Foundation
import Alamofire

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders { get }
}

extension Endpoint {
    var baseUrl: String {
        return "https://api.themoviedb.org/3"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders {
        [
            HTTPHeader(name: "Authorization", value: "Bearer \(MOVIE_DB_TOKEN)"),
            HTTPHeader(name: "Content-Type", value: "application/json")
        ]
    }
    
    var url: String {
        return baseUrl + path
    }
}
