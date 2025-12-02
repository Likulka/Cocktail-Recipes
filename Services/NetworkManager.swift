//
//  NetworkManager.swift
//  Coctail Recipes
//
//  Created by Anzhelika on 25.11.25.
//

@preconcurrency import Foundation
import UIKit

enum NetworkError: Error {
    case decodingError
    case noData
    case invalidURL
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(
        _ type: T.Type,
        from baseURL: URL,
        paramName: String? = nil,
        paramValue: String? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void) {
            var finalUrl = baseURL

            if let name = paramName, let value = paramValue {
                let encodedVlue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
                let queryString = finalUrl.absoluteString + "?\(name)=\(encodedVlue)"
                
                guard let url = URL(string: queryString) else {
                    completion(.failure(.invalidURL))
                    return
                }
                
                finalUrl = url
                print(finalUrl)

            }
            
            
            
            URLSession.shared.dataTask(with: finalUrl) { data, _, error in
                guard let data else {
                    completion(.failure(.noData))
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let dataModel = try decoder.decode(T.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(dataModel))
                    }

                } catch {
                print("Error: \(error)")
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
    
    func loadImage(from stringURL: String, with completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            completion(data)
        }.resume()
    }
    
}
