//
//  NetworkManager.swift
//  MovieAppExample
//
//  Created by Ensar on 17.06.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    func request<T: Codable>(type: T.Type, item: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(item.url, method: item.method, headers: item.header).responseData { response in
            switch response.result {
            case .success(let data):
                print("###### Request cURL; \n\n \(response.request?.cURL() ?? "") ######\n\n")
                
                print("###### Response json \(item.path) ######\n")
                data.printJson()
                let response = try! JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
