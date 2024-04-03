//
//  ReviewsViewModel.swift
//  MovieAppExample
//
//  Created by Ensar on 2.04.2024.
//

import Foundation

class ReviewsViewModel {
    
    private let networkManager: NetworkManager
    
    var reviews: [Review] = []
    var reviewsID: Int = 0
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchReviews(completion: @escaping (Result<Void, Error>) -> Void) {
        let reviewsItem = ReviewsEndpointItem(movieId: reviewsID)
        networkManager.request(type: ReviewsResponse.self, item: reviewsItem) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let response):
                if let reviews = response.results {
                    self.reviews = reviews
                    completion(.success(()))
                } else {
                    completion(.failure(NSError(domain: "InvalidData", code: 0, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
