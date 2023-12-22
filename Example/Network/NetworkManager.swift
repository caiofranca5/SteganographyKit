//
//  NetworkManager.swift
//  Example
//
//  Created by Caio França on 21/12/23.
//  Copyright © 2023 SteganographyKit. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    var session: URLSession { get }
    func request<T: Decodable>(endpoint: API, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    private class func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }

    func request<T: Decodable>(endpoint: API, completion: @escaping (Result<T, Error>) -> Void) {
        let components = NetworkManager.buildURL(endpoint: endpoint)
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue

        if endpoint.method == .post {
            urlRequest.httpBody = endpoint.requestBody
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let session = self.session
        let dataTask = session.dataTask(with: urlRequest) {
            data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let _ = response as? HTTPURLResponse, let data = data else {
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        dataTask.resume()
    }
}

