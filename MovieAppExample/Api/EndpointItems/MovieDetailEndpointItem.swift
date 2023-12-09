//
//  MovieDetailEndpointItem.swift
//  MovieAppExample
//
//  Created by Ensar on 30.11.2023.
//

import Foundation

struct MovieDetailEndpointItem: Endpoint {
    var movieId : Int
    var path: String {
     
        return "/movie/\(movieId)"
    }
}
