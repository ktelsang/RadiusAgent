//
//  MockNetworkService.swift
//  RadiusTests
//
//  Created by Kavyashree Hegde on 29/06/23.
//

import Foundation
@testable import Radius

class MockNetworkService: NetworkServiceProtocol {
    func sendRequest<T>(endpoint: Radius.Endpoint, responseModel: T.Type) async -> Result<T, Radius.NetworkError> where T : Decodable, T : Encodable {
        return .success(MockJSON().getMockObject())
    }    
}

extension NetworkServiceProtocol {
    func sendInvalidUrlRequest<T>(endpoint: Radius.Endpoint, responseModel: T.Type) async -> Result<T, Radius.NetworkError> where T : Decodable, T : Encodable {
        return .failure(.invalidURL)
    }
}
