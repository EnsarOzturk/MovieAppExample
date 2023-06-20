//
//  NetworkManager.swift
//  MovieAppExample
//
//  Created by Ensar on 17.06.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    func fetchPopularMovies(item: DiscoverMovieEndpointItem, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
                
        AF.request(item.url, method: item.method, headers: item.header).responseData { response in
            switch response.result {
            case .success(let data):
                print(data)
                let response = try! JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            
            }
        }
    }
    
    func fetchReviewMovies(item: ReviewsEndpointItem, completion: @escaping (Result<ReviewsResponse, Error>) -> Void) {
                
        AF.request(item.url, method: item.method, headers: item.header).responseData { response in
            switch response.result {
            case .success(let data):
                print(data)
                let response = try! JSONDecoder().decode(ReviewsResponse.self, from: data)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchVideoMovies(item: VideosEndpointItem, completion: @escaping (Result<VideosResponse, Error>) -> Void) {
        
        AF.request(item.url, method: item.method, headers: item.header).responseData { response in
            switch response.result {
            case .success(let data):
                print(response)
                let response = try! JSONDecoder().decode(VideosResponse.self, from: data)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}
