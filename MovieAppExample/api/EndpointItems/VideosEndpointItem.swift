//
//  VideosEndpointItem.swift
//  MovieAppExample
//
//  Created by Ensar on 20.06.2023.
//

struct VideosEndpointItem: Endpoint {
    var movieId: Int
    var path: String {
        return "/movie/\(movieId)/videos"
    }
}
