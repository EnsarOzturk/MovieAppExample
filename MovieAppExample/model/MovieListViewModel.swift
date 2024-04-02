//
//  MovieListViewModel.swift
//  MovieAppExample
//
//  Created by Ensar on 2.04.2024.
//

import Foundation

class MovieListViewModel {
    
    private let networkManager: NetworkManager
    private var movies: [Movie] = []
    private var filteredMovies: [Movie] = []
   
    var viewStyle: ViewStyle = .small
    
    var numberOfMovies: Int {
        return isSearching ? filteredMovies.count : movies.count
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchMovies(completion: @escaping (Result<Void, Error>) -> Void) {
        networkManager.request(type: MovieResponse.self, item: DiscoverMovieEndpointItem()) { result in
            switch result {
            case .success(let response):
                if let fetchedMovies =  response.results {
                    self.movies = fetchedMovies
                    completion(.success(()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func movie(at index: Int) -> Movie {
        return isSearching ? filteredMovies[index] : movies[index]
    }
    
    func filterMovies(with searchText: String) {
        if searchText.isEmpty {
            filteredMovies.removeAll()
        } else {
            filteredMovies = movies.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }
    
    var isSearching: Bool {
        return !filteredMovies.isEmpty
    }
    
    func toggleViewStyle() {
        viewStyle = (viewStyle == .small) ? .big : .small
    }
}

enum ViewStyle {
    case small
    case big
}

