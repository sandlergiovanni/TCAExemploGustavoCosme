//
//  ApiClient.swift
//  TCAExemploGustavoCosme
//
//  Created by Sandler Maciel on 18/10/25.
//

import Foundation

struct ApiClient {
    var apiKey: String
    var session: URLSession = .shared
    private var baseUrl: URL = URL(string: "https://api.themoviedb.org/3/")!

    func fetchData<T: Codable>(page: Int = 1,
                               path: String,
                               extraQueryParams: [URLQueryItem] = [],
                               language: String? = nil) async -> Result<T?, BaseError> {
        var components = URLComponents(url: baseUrl.appendingPathComponent(path),
                                       resolvingAgainstBaseURL: false)!
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        if extraQueryParams.count > 0 {
            queryItems.append(contentsOf: extraQueryParams)
        }
        if let language = language {
            queryItems.append(URLQueryItem(name: "language", value: language))
        }

        components.queryItems = queryItems

        guard let (data, response) = try? await session.data(from: components.url!),
              let response = response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else {
            return .failure(BaseError(errorMessage: "Request error", errorCode: URLError.badServerResponse.rawValue))
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let result = try? decoder.decode(T.self, from: data) else {
            return .failure(BaseError(errorMessage: "Failed to decode data", errorCode: 0))
        }
        return .success(result)
    }

    func configuration() async throws -> Configuration {
        var components = URLComponents(url: baseUrl.appendingPathComponent("configuration"),
                                       resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        let (data, response) = try await session.data(from: components.url!)
        guard let http = response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Configuration.self, from: data)
    }
}
