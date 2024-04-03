//
//  MovieDetailViewModel.swift
//  MovieAppExample
//
//  Created by Ensar on 2.04.2024.
//

import Foundation

class MovieDetailViewModel {
    
    private let networkManager: NetworkManager
    private var movieDetails: MovieDetailResponse?
    private var imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    
    var movieId: Int = 0
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchMovieDetails(completion: @escaping (Result<Void, Error>) -> Void) {
        let movieDetailItem = MovieDetailEndpointItem(movieId: movieId)
        networkManager.request(type: MovieDetailResponse.self, item: movieDetailItem) { result in
            switch result {
            case .success(let movieDetail):
                self.movieDetails = movieDetail
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    var backdropImageUrl: URL? {
        guard let backdropPath = movieDetails?.backdropPath else { return nil }
        return URL(string: imageBaseUrl + backdropPath)
    }
    
    var originalTitle: String? {
        return movieDetails?.originalTitle
    }
    
    var releaseDate: String? {
        return movieDetails?.releaseDate
    }
    
    var voteAverage: String {
        return String(movieDetails?.voteAverage ?? 0)
    }
    
    var overview: String? {
        return movieDetails?.overview
    }
    
    var voteCount: String {
        return String(movieDetails?.voteCount ?? 0)
    }
}

