//
//  GitHubApi.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

import Foundation

enum GitHubApi {
    // subs
    case searchRespositories(SearchParameters)
    
    private var urlString: String {
        let base = "https://api.github.com"
        switch self {
        case .searchRespositories(let parameters):
            return "\(base)/search/repositories?\(parameters.query)"
        }
    }
    
    private var method: HttpMethod {
        switch self {
        case .searchRespositories:
            return .get
        }
    }

    func request(withBody body: Data? = nil) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw ApiError.urlError("invalid url: \(urlString)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "accept")
        request.httpBody = body
        return request
    }
    
    struct SearchParameters {
        let qualifiers: String
        let sort: String
        let order: String
        
        var query: String {
            return "q=\(qualifiers)&sort=\(sort)&order=\(order)"
        }
    }
}

extension HTTPURLResponse {
    var isValidResponse: Bool {
        return 200..<299 ~= statusCode
    }
}

extension URLRequest {
    func send<T: Decodable>(completion: @escaping (Result<T, ApiError>)-> Void) {
        URLSession.shared.dataTask(with: self) { (data, response, error) in
            if let error = error {
                completion(.failure(ApiError.unknown(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.isValidResponse, let data = data else {
                completion(.failure(ApiError.invalidedResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                completion(.success(value))
            } catch {
                completion(.failure(ApiError.decodingError))
            }
            
        }.resume()
    }
    
    func send<T: Decodable>() async throws -> T {
        do {
            let (data, response)  = try await URLSession.shared.data(for: self, delegate: nil)
            
            guard let response = response as? HTTPURLResponse, response.isValidResponse else {
                throw ApiError.invalidedResponse
            }
            
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch is DecodingError {
            throw ApiError.decodingError
        } catch {
            throw ApiError.unknown(error)
        }
    }
}



