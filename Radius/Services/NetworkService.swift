//
//  NetworkService.swift
//  Radius
//
//  Created by Kavyashree Hegde on 28/06/23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "my-json-server.typicode.com"
    }
}

enum NetworkError: Error, CustomStringConvertible {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var description: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .noResponse:
            return "No Response"
        case .invalidURL:
            return "Invalid URL"
        case .unexpectedStatusCode:
            return "Unexpected status code"
        default:
            return "Unknown error"
        }
    }
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

protocol NetworkServiceProtocol {
    func sendRequest<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, NetworkError>
}

class NetworkService: NetworkServiceProtocol {
    func sendRequest<T: Codable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, NetworkError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        if let header = endpoint.header {
            request.allHTTPHeaderFields = header
        }
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            switch response.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                guard let decodedResponse = try? decoder.decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
            
        } catch {
            return .failure(.unknown)
        }
    }
}
