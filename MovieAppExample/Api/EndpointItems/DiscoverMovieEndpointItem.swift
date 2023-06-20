//
//  PopularMovieEndpointItem.swift
//  MovieAppExample
//
//  Created by Ensar on 20.06.2023.
//

struct DiscoverMovieEndpointItem: Endpoint {
    var path = "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
}
